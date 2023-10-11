const _ = require('lodash');

module.exports = function middelwares() {
  function middlewareCorsHeader(req, ses, next) {
    // TODO: Add response header to res.setHeader() for CORS requests here.

    if (req.method === 'OPTIONS') {
      res.status(200).end();
      return;
    }

    next();
    return;
  }

  return { middlewareCorsHeader };
};
