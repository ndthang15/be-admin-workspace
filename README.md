# be-admin-workspace
This is a course workspace for Express API with Postgres and Jest

## Run locally
- Use Node v16
- Install packages
```
npm install
```
- Start project
```
npm start
```
- Try `http://localhost:6065` to test the root route

## Install Flyway
- Before install and run Flyway, we need to create Database `adminDb`
  - Connect to default DB `postgres`
  - Execute the SQL query
  ```
  CREATE DATABASE adminDB;
  ```
- Run command to install Flyway from Flyway host
```
wget -qO- https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/9.10.2/flyway-commandline-9.10.2-linux-x64.tar.gz | tar xvz && sudo ln -s `pwd`/flyway-9.10.2/flyway /usr/local/bin
```
- Replace your HOME_PATH into the `/flyway/postgre/migrations/config/flyway-config.conf` file.
- Exec below command from the root path of project
```
sudo flyway -configFiles=./flyway/postgre/migrations/config/flyway-config.conf migrate
```