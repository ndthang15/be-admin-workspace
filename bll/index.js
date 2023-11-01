module.exports = (app) => {
  return {
    users: require('./users')(app),
    organizations: require('./organizations')(app),
    roles: require('./roles')(app),
    userProfiles: require('./userProfiles')(app),
  }
};  