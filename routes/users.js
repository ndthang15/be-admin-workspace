const express = require('express');

module.exports = function (app, middelwares) {
  if (!app) {
    throw new Error('missing app');
  }

  const routerOrganizations = express.Router();

  //TODO: Add Router-level middlewares

  //TODO: Add the Route-level middleware to response 401 if any falling through
  app.use('/users', routerOrganizations);

  //TODO: Add the routes for organization model
  routerOrganizations.get('/', getUsers);

  async function getUsers(req, res, next) {
    try {
      // validation params if needed
      const options = req.body;
      const results = await app.bll.users.getUsers(options);

      return res.status(200).send(results);
    } catch (err) {
      return next(err);
    }
  }
};