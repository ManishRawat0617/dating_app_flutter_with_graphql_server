const { Pool } = require("pg");
require("dotenv").config();

const config = {
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: parseInt(process.env.DB_PORT, 10),
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
};

const pool = new Pool(config);

// Test connection once at startup
pool.query("SELECT NOW()")
  .then(() => {
    console.log(" PostgreSQL Database connected successfully");
  })
  .catch((err) => {
    console.error("Error connecting to PostgreSQL database:", err.message);
  });

// Set date style on each new client connection
pool.on("connect", (client) => {
  client.query("SET DATESTYLE = iso, mdy");
});

module.exports = pool;
