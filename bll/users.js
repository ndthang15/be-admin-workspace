const _ = require('lodash');

module.exports = (app) => {

  async function getUsers(options) {
    const users = await app.dal.users.getUsers(options);

    return users;
  }

  return { getUsers };
};