const _ = require('lodash');
const camelcaseKeys = require('camelcase-keys');
const DEFAULT_LIMIT = 30;
const DEFAULT_OFFSET = 0;

module.exports = (app) => {
  const db = app.pg;

  async function getRole(roleId, dbClient = db) {
    if (!roleId) {
      throw new Error('roleId is required.');
    }

    const resultQuery = await getRoles({ roleId }, dbClient);

    if (_.isEmpty(resultQuery.rows)) {
      throw new Error('Role Not Found');
    }
    return camelcaseKeys(resultQuery.rows[0], { deep: true });
  }

  async function getRoles(options, dbClient = db) {
    const sqlWhere = [];
    const sqlParams = [];
    let sql = `
        SELECT r.role_id,
            r.role_name,
            r.role_description,
            r.org_id
        FROM public.sso_role r
    `;

    if (options.id) {
      sqlParams.push(options.id);
      sqlWhere.push(`r.role_id = $${sqlParams.length}`);
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

  async function createRole(params, dbClient = db) {
    const { roleName } = params || {};
    if (!roleName) {
        throw new Error('roleName is required.');
    }
    const sql = `
      INSERT INTO
        sso_role(
          role_name,
          role_description,
          org_id
        )
      VALUES (
        ${params.roleName},
        ${params.roleDescription},
        ${params.orgId}
      )
    `;
    const newRole = await dbClient.query(sql, (result) => {
      return camelcaseKeys(result, { deep: true });
    });
    return newRole;
  }

  async function updateRole(params, dbClient = db) {
    if (!roleId) {
      throw new Error('roleId is required.');
    }
    const sql = `
      UPDATE sso_role
      SET
        role_name = ${params.roleName},
        role_description =  ${params.roleDescription},
        org_id = ${params.orgId}
      WHERE role_id = ${params.roleId}
    `;
    const updatedRole = await dbClient.query(sql, (result) => {
      return camelcaseKeys(result, { deep: true });
    });
    return updatedRole;
  }

  async function deleteRole(roleId, dbClient = db) {
    if (!roleId) {
      throw new Error('roleId is required.');
    }
    const sql = `
      DELETE FROM sso_role WHERE role_id = ${roleId}
    `;
    const deletedRole = await dbClient.query(sql, (result) => {
      return camelcaseKeys(result, { deep: true });
    });
    return deletedRole;
  }

  return { getRole, getRoles, createRole, updateRole, deleteRole };
};