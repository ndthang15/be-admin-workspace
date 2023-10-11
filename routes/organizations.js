const express = require('express');

module.exports = function (app, middelwares) {
  if (!app) {
    throw new Error('missing app');
  }

  const routerOrganizations = express.Router();

  //TODO: Add Router-level middlewares

  //TODO: Add the Route-level middleware to response 401 if any falling through
  app.use('/organizations', routerOrganizations);

  //TODO: Add the routes for organization model
  // EX: app.get('/', function handle(req, res, next){})
};