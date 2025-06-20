const { mergeTypeDefs, mergeResolvers } = require("@graphql-tools/merge");
const { makeExecutableSchema } = require("@graphql-tools/schema");

// load graphql schema
const userSchema = require("../graphql_schema/user_schema");
const likeSchema = require("../graphql_schema/like_schema");
const matchSchema = require("../graphql_schema/match_schema");
const photoSchema = require("../graphql_schema/photo_schema");
const reportSchema = require("../graphql_schema/report_schema");
const messageSchema = require("../graphql_schema/match_schema");
const blockSchema = require("../graphql_schema/block_schema");
const userPreferenceSchema = require("../graphql_schema/user_preferences_schema");
const userPersonalitySchema = require("../graphql_schema/user_personality_schema");
const userLifestyleSchema = require("../graphql_schema/user_lifestyle_schema");
// Merge type definitions and resolvers
const typeDefs = mergeTypeDefs([
  userSchema.userTypeDefs,
  likeSchema.likeTypeDefs,
  matchSchema.matchTypeDefs,
  photoSchema.photoTypeDefs,
  reportSchema.reportTypeDefs,
  messageSchema.matchTypeDefs,
  blockSchema.blockTypeDefs,
  userPreferenceSchema.userPreferenceTypeDefs,
  userPersonalitySchema.personalityTypeDefs,
  userLifestyleSchema.lifestyleTypeDefs,
]);

const resolvers = mergeResolvers([
  userSchema.userResolvers,
  likeSchema.likeResolvers,
  matchSchema.matchResolvers,
  photoSchema.photoResolvers,
  reportSchema.reportResolvers,
  messageSchema.matchResolvers,
  blockSchema.blockResolvers,
  userPreferenceSchema.userPreferenceResolvers,
  userPersonalitySchema.personalityResolvers,
  userLifestyleSchema.lifestyleResolvers,
]);

const schema = makeExecutableSchema({
  typeDefs,
  resolvers,
});

module.exports = { schema };
