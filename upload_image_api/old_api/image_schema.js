const mongoose = require("mongoose");

const imageSchema = new mongoose.Schema({
  userID: {
    type: String,
    require: true,
  },
  filename: String,
  path: String,

  uploadedAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model("Image", imageSchema);
