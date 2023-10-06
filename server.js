
const express = require('express');
const app = express();
const cookieParser = require('cookie-parser');

app.use(express.json());

// load the cookie-parsing middleware
app.use(cookieParser());

app.get('/', (req, res) => {
  return res.status(200).send('You are welcome!');
});

app.listen(6065, function onListening() {
    console.log('Listening to port ' + 6065);
});