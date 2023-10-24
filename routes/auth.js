const express = require('express');
const bcrypt = require('bcrypt');
const uuid = require('uuid');

module.exports = function (app) {
  if (!app) {
    throw new Error('missing app');
  }

  const routerAuth = express.Router();

  app.use('/auth', routerAuth);

  routerAuth.post('/login', login);

  async function login(req, res, next) {
    const username = req.body.username;
    const password = req.body.password;
    
    const userLogin = await app.dal.users.getUserByUserName(username);
    if (!userLogin) {
      return res.status(400).send({ message: 'Inavlid username' });
    }

    const validate = bcrypt.compareSync(password, userLogin.password);
    if (validate) {
      const userToken = uuid.v4();
      const sessionKey = 'SESSION:' + userToken;

      // TODO: Get Roles for User
      // TODO: Assign all permissions of User to userLogin object
      // Ex: userLogin.permissions = [1,2,3,...];

      await app.redis.set(sessionKey, userLogin);

      return res.status(200).send({ message: "Login successful", token: userToken });
    }

    return res.status(400).send({ message: "Invalid password" });
  }
};