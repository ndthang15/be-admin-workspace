
const express = require('express');
const app = express();
const cookieParser = require('cookie-parser');
const path = require('path');
require('dotenv').config({
  override: true,
  path: path.join(__dirname, 'development.env')
});

const initSwagger = require('./modules/swagger/swagger');
const initRouters = require('./routes');

// Build-in middlewares
app.use(express.json());

//TODO: Application-level middlwares

// load the cookie-parsing middleware
app.use(cookieParser());

app.get('/', (req, res) => {
  return res.status(200).send('You are welcome!');
});

app.pg = require('./modules/postgres')();
app.dal = require('./dal')(app);
app.bll = require('./bll')(app);

app.listen(6065, function onListening() {
    console.log('Listening to port ' + 6065);
});
initSwagger(app, express);
initRouters(app);


//TODO: Add error-handling middlewares here