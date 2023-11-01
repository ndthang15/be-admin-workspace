const _ = require('lodash');
const camelcaseKeys = require('camelcase-keys');
const DEFAULT_LIMIT = 30;
const DEFAULT_OFFSET = 0;

module.exports = (app) => {
  const db = app.pg;

  async function getUserProfile(profileId, dbClient = db) {
    if (!profileId) {
      throw new Error('profileId is required.');
    }

    const resultQuery = await getUserProfiles({ profileId }, dbClient);

    if (_.isEmpty(resultQuery.rows)) {
      throw new Error('User Profile Not Found');
    }
    return camelcaseKeys(resultQuery.rows[0], { deep: true });
  }

  async function getUserProfiles(options, dbClient = db) {
    const sqlWhere = [];
    const sqlParams = [];
    let sql = `
        SELECT sup.profile_id,
            sup.user_id,
            sup.birth_date,
            sup.sex,
            sup.title,
            sup.first_name,
            sup.last_name,
            sup.avatar,
            sup.age,
            sup.address,
            sup.date_created,
            sup.date_modified
        FROM public.sso_user_profile sup
    `;

    if (options.id) {
      sqlParams.push(options.id);
      sqlWhere.push(`sup.profile_id = $${sqlParams.length}`);
    }

    if (sqlWhere.length) {
      sql += ' WHERE ' + sqlWhere.join(' AND ');
    }

    if (Number.isInteger(options.limit)) {
      sql += ` LIMIT ${options.limit || DEFAULT_LIMIT}`;
    }
    if (Number.isInteger(options.offset)) {
      sql += ` OFFSET ${options.offset || DEFAULT_OFFSET}`;
    }

    const resultQuery = await dbClient.query(sql, sqlParams, (result) => {
      return camelcaseKeys(result.rows, { deep: true });
    });

    return {
      count: resultQuery.length,
      results: resultQuery,
      limit: options.limit || DEFAULT_LIMIT,
      offset: options.offset || DEFAULT_OFFSET,
    };
  }

  return { getUserProfile, getUserProfiles };
};
