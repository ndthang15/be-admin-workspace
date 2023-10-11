const express = require('express');

module.exports = function (app) {
  if (!app) {
    throw new Error('missing app');
  }

  const routerAuth = express.Router();

  app.use('/auth', routerAuth);

  routerAuth.post('/login', login);

  function login(req, res, next) {
    const hardCodeUserName = 'mock-user';
    const hardCodPpassword = 'mock123';
    //TODO: Please hash the mock password with saltRounds = 12 and fill to hashPassword
    let hashPassword = ''

    //TODO: Use the bcrypt to verify the req.body.username and req.body.password which should match the hashPassword above

    // if success response HTTP 200 OK
    // else response HTTP 400 Invalid Username or Password

    return res.status(400).send('Invalid Username or Password');
  }
};