const mongoose = require("mongoose");

require("dotenv").config();

mongoose
  .connect(process.env.MONGO_DB_URL)
  .then(() => {
    console.log("MongoDB connected successfully");
  })
  .catch((err) => console.log("Failed to connect to mongodb", err));

module.exports = mongoose;
