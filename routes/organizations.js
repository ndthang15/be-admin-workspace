const express = require('express');

module.exports = function (app, middlewares) {
  if (!app) {
    throw new Error('missing app');
  }

  const routerOrganizations = express.Router();
  routerOrganizations.get('/', getOrganizations);
  routerOrganizations.get('/:organizationId', getOrganization);
  routerOrganizations.post('/', createOrganization);
  routerOrganizations.put('/:organizationId', updateOrganization);
  routerOrganizations.delete('/:organizationId', deleteOrganization);

  app.use('/organizations', routerOrganizations);

  async function getOrganizations(req, res, next) {
    try {
      // TODO: validate request params
      const options = req.query;
      const results = await app.bll.organizations.getOrganizations(options);
      return res.status(200).send(results);
    } catch (err) {
      return next(err);
    }
  }

  async function getOrganization(req, res, next) {
    try {
      // TODO: validate params
      const organizationId = parseInt(req.params.organizationId);
      const organization = await app.bll.organizations.getOrganization(organizationId);

      if (!organization) {
        return res.status(404).send({ error: 'Organization not found' });
      }

      return res.status(200).send(organization);
    } catch (err) {
      return next(err);
    }
  }

  async function createOrganization(req, res, next) {
    try {
      // TODO: validate request body
      const organizationData = req.body;
      const newOrganization = await app.bll.organizations.createOrganization(organizationData);
      return res.status(201).send(newOrganization);
    } catch (err) {
      return next(err);
    }
  }

  async function updateOrganization(req, res, next) {
    try {
      // TODO: validate request params and body
      const organizationId = parseInt(req.params.organizationId);
      const organizationData = req.body;
      const updatedOrganization = await app.bll.organizations.updateOrganization(
        organizationId,
        organizationData
      );

      if (!updatedOrganization) {
        return res.status(404).send({ error: 'Organization not found' });
      }

      return res.status(200).send(updatedOrganization);
    } catch (err) {
      return next(err);
    }
  }

  async function deleteOrganization(req, res, next) {
    try {
      // TODO: validate request params
      const organizationId = parseInt(req.params.organizationId);
      await app.bll.organizations.deleteOrganization(organizationId);
      return res.status(204).send();
    } catch (err) {
      return next(err);
    }
  }
};