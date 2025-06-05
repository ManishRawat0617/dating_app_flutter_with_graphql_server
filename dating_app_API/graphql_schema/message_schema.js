const Message = require("../mongodb_model/message_model");

const messageTypeDefs = `
type Message {
  id: ID!
  match_id: ID!
  sender_id: ID!
  content: String!
  media_url: String
  timestamp: String
}

type Query {
  getAllMessages: [Message!]
  getMessagesByMatch(match_id: ID!): [Message!]
  getMessageById(id: ID!): Message
}

type Mutation {
  addMessage(match_id: ID!, sender_id: ID!, content: String!, media_url: String): Message
  updateMessage(id: ID!, content: String, media_url: String): Message
  deleteMessage(id: ID!): Message
}
`;

const messageResolvers = {
  Query: {
    getAllMessages: async () => {
      return await Message.find();
    },

    getMessagesByMatch: async (_, { match_id }) => {
      return await Message.find({ match_id }).sort({ timestamp: 1 });
    },

    getMessageById: async (_, { id }) => {
      return await Message.findById(id);
    },
  },

  Mutation: {
    addMessage: async (_, { match_id, sender_id, content, media_url }) => {
      const message = new Message({ match_id, sender_id, content, media_url });
      return await message.save();
    },

    updateMessage: async (_, { id, content, media_url }) => {
      return await Message.findByIdAndUpdate(
        id,
        { content, media_url },
        { new: true }
      );
    },

    deleteMessage: async (_, { id }) => {
      return await Message.findByIdAndDelete(id);
    },
  },
};

module.exports = { messageTypeDefs, messageResolvers };
