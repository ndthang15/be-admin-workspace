const _ = require('lodash');

module.exports = (app) => {
  async function getUserProfile(userId) {
    const userProfile = await app.dal.userProfiles.getUserProfile(userId);

    return userProfile;
  }

  async function getUserProfiles(options) {
    const userProfiles = await app.dal.userProfiles.getUserProfiles(options);

    return userProfiles;
  }

  return { getUserProfile, getUserProfiles };
};
