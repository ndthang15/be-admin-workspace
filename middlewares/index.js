const _ = require("lodash");

module.exports = function middlewares(app) {
  function middlewareCorsHeader(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header(
      "Access-Control-Allow-Methods",
      "GET, POST, DELETE, PATCH, OPTIONS"
    );
    res.header("Access-Control-Allow-Headers", "Content-Type, Authorization");

    if (req.method === "OPTIONS") {
      res.status(200).end();
      next();
    }

    next();
    return;
  }

  // Authorization middlewares
  function requirePermissions(requirePerms) {
    return async (req, res, next) => {
      const authToken = getAuthToken(req);

      if (!authToken) {
        return res.status(401).send({ message: 'Missing Authorization header.' });
      }

      const sessionKey = 'SESSION:' + authToken;
      const userInfoFromCache = await app.redis.get(sessionKey);

      if (userInfoFromCache) {
        // TODO: Validate and compare the Permissions
        // If valid
        // return next();
      }

      return res.status(401).send({ message: 'Unauthorized' });
    };
  }

  // Authentication
  function requireAuthentication(req, res, next) {
    const authToken = getAuthToken(req);

    if (_.isEmpty(authToken)) {
      return res.status(401).send({ message: 'Missing Authorization header.' });
    }
    _.set(req, 'context.isAuthenticated', true);
    _.set(req, 'context.authToken', authToken);

    return next();
  }

  function getAuthToken(req) {
    const authHeader = _.get(req, 'headers.authorization');
    let authToken;
    if (!_.isEmpty(authHeader)) {
      const authorization = authHeader.split(' ');
      if (
        authorization.length > 1 &&
        authorization[0].toLowerCase() === 'bearer' &&
        authorization[1].length > 0
      ) {
        authToken = authorization[1];
      }
    }

    return authToken;
  }

  return { middlewareCorsHeader, requirePermissions, requireAuthentication };
};
