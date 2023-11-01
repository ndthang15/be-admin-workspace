function initRouters(app) {
  if (!app) {
    throw new Error('Missing app for routes index!');
  }

  const middlewares = require('../middlewares')();

  // add the Application-level middlewares here

  // API for the root path
  app.get('/', function (req, res) {
    app.use(middlewares.middlewareCorsHeader(req, res));
    return res.status(200).json({ message: 'Welcome' });
  });

  require('./auth')(app);
  require('./organizations')(app, middlewares);
  require('./users')(app, middlewares);
  require('./roles')(app, middlewares);
  require('./userProfiles')(app, middlewares);
}

module.exports = initRouters;
