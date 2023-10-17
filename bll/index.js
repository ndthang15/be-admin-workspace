module.exports = (app) => {
  return {
    users: require('./users')(app),
    organizations: require('./organizations')(app)
  }
};  