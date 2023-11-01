const express = require('express');

module.exports = function (app, middlewares) {
  if (!app) {
    throw new Error('missing app');
  }

  const routerRoles = express.Router();

  //TODO: Add Router-level middlewares

  //TODO: Add the Route-level middleware to response 401 if any falling through
  app.use('/roles', routerRoles);

  //TODO: Add the routes for organization model
  routerRoles.get('/', getRoles);
  routerRoles.get('/:roleId', getRoleDetail);
  routerRoles.post('/create', createRole);
  routerRoles.put('/:roleId', updateRole);
  routerRoles.delete('/:roleId', deleteRole);

  async function getRoles(req, res, next) {
    try {
      // validation params if needed
      const options = req.query;
      const results = await app.bll.roles.getRoles(options);

      return res.status(200).send(results);
    } catch (err) {
      return next(err);
    }
  }

  async function getRoleDetail(req, res, next) {
    try {
      // validation params if needed
      const roleId = req.query.roleId;
      const result = await app.bll.roles.getRole(roleId);

      return res.status(200).send(result);
    } catch (err) {
      return next(err);
    }
  }

  async function createRole(req, res, next) {
    try {
      // validation params if needed
      const params = req.body;
      console.log('-----', req);
      const result = await app.bll.roles.createRole(params);

      return res.status(201).send(result);
    } catch (err) {
      return next(err);
    }
  }

  async function updateRole(req, res, next) {
    try {
      // validation params if needed
      const params = req.body;
      const result = await app.bll.roles.updateRole(params);

      return res.status(200).send(result);
    } catch (err) {
      return next(err);
    }
  }

  async function deleteRole(req, res, next) {
    try {
      // validation params if needed
      const roleId = req.query.roleId;
      const result = await app.bll.roles.deleteRole(roleId);

      return res.status(200).send(result);
    } catch (err) {
      return next(err);
    }
  }
};
