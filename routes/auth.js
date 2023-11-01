const express = require("express");
const bcrypt = require("bcrypt");

module.exports = function (app) {
  if (!app) {
    throw new Error("missing app");
  }

  const routerAuth = express.Router();

  app.use("/auth", routerAuth);

  routerAuth.post("/login", login);

  function login(req, res, next) {
    const hardCodeUserName = "mock-user";
    const hardCodePassword = "mock123";
    // Hash the mock password with saltRounds = 12 and fill to hashPassword
    let hashPassword =
      "$2a$12$TNhphTbTg6Yr3r6YHxCituvo8pKP9cbuFuat7.tcmXKdM7F2EIVPC";

    // Use the bcrypt to verify the req.body.username and req.body.password which should match the hashPassword above
    if (req.body.username === hardCodeUserName) {
      validatePassword(hardCodePassword, hashPassword)
        .then((isValidPassword) => {
          if (isValidPassword) {
            return res.status(200).send("OK");
          }
        })
        .catch((err) => {
          console.error(err.message);
          return res.status(400).send("Invalid Username or Password");
        });
    }

    return res.status(400).send("Invalid Username or Password");
  }

  function genHashWithSalt(password, saltRounds) {
    bcrypt
      .genSalt(saltRounds)
      .then((salt) => {
        return bcrypt.hash(password, salt);
      })
      .then((hash) => {
        return hash;
      })
      .catch((err) => {
        console.error(err.message);
      });
  }

  function validatePassword(password, hash) {
    bcrypt
      .compare(password, hash)
      .then((res) => {
        return res;
      })
      .catch((err) => console.error(err.message));
  }
};
