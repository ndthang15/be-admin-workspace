
const express = require('express');
const app = express();
const cookieParser = require('cookie-parser');
const initRouters = require('./routes');

// Build-in middlewares
app.use(express.json());

//TODO: Application-level middlwares

// load the cookie-parsing middleware
app.use(cookieParser());

app.get('/', (req, res) => {
  return res.status(200).send('You are welcome!');
});

app.listen(6065, function onListening() {
    console.log('Listening to port ' + 6065);
});

initRouters(app);


//TODO: Add error-handling middlewares here