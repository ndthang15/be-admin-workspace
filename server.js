const cookieParser = require("cookie-parser");
const express = require("express");
const app = express();
const path = require("path");
const PORT = 6065;

require("dotenv").config({
  override: true,
  path: path.join(__dirname, "development.env"),
});

const initSwagger = require('./modules/swagger/swaggerInit');
const initRouters = require("./routes");

app.use(express.json());

//TODO: Application-level middleware

app.use(cookieParser());

app.get("/", (req, res) => {
  return res.status(200).send({ message: "You are welcome!" });
});

app.pg = require('./modules/postgres/postgresConfig')();
app.redis = require('./modules/redis')(app);
app.middlewares = require("./middlewares")(app);
app.dal = require("./dal")(app);
app.bll = require("./bll")(app);

app.use(app.middlewares.middlewareCorsHeader);

app.listen(PORT, function onListening() {
  console.log("Listening to port " + PORT);
});

initSwagger(app, express);
initRouters(app);

//TODO: Add error-handling middlewares here
