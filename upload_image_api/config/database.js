const { Pool } = require("pg");

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "dating_app",
  password: "1331",
  port: 5432,
});

module.exports = pool;
