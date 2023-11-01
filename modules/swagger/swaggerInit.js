const YAML = require('yamljs');
const path = require('path');

module.exports = function initSwagger(app, express) {
  if (!app || !express) {
    throw new Error('Missing app or express');
  }

  const swaggerDoc = YAML.load(path.join(__dirname, 'swaggerConfig.yaml'));
  const swaggerUI = require('swagger-ui-express');

  app.use(express.static(path.join(__dirname, 'public')));
  app.use('/api-docs', swaggerUI.serve, swaggerUI.setup(swaggerDoc));
};