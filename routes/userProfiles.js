const express = require('express');

module.exports = function (app, middelwares) {
  if (!app) {
    throw new Error('missing app');
  }

  const routerUserProfiles = express.Router();

  //TODO: Add Router-level middlewares

  //TODO: Add the Route-level middleware to response 401 if any falling through
  app.use('/userProfiles', routerUserProfiles);

  //TODO: Add the routes for organization model
  routerUserProfiles.get('/', getUserProfiles);

  async function getUserProfiles(req, res, next) {
    try {
      // validation params if needed
      const options = req.query;
      const results = await app.bll.userProfiles.getUserProfiles(options);

      return res.status(200).send(results);
    } catch (err) {
      return next(err);
    }
  }

  
};