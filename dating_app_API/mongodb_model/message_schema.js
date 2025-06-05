const mongoose = require("mongoose");

const messageSchema = new mongoose.Schema({
  match_id: { type: String, required: true },
  sender_id: { type: String, required: true },
  content: { type: String, required: true },
  media_url: { type: String, default: null },
  timestamp: { type: Date, default: Date.now }
});

const Message = mongoose.model("Message", messageSchema);

module.exports = Message;
