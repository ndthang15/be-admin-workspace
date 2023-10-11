function initRouters(app) {
  if (!app) {
    throw new Error('Missing app for routes index!');
  }

  const middelwares = require('../middlewares')();
  
  //TODO: we can also add the Application-level middlewares here

  // API for the roor path
  app.get('/', function (req, res) {
    return res.status(200).json({ message: 'Welcome' });
  });

  require('./auth')(app);
  require('./organizations')(app, middelwares);
}

module.exports = initRouters;