const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");

const hashPassword = async (password) => await bcrypt.hash(password, 10);

const comparePassword = async (input, stored) =>
  await bcrypt.compare(input, stored);

const generateToken = (userId, email) =>
  jwt.sign({ id: userId, email: email }, process.env.JWT_SECRET, {
    expiresIn: "1h",
  });

const authenticate = (authHeader) => {
  if (!authHeader) throw new Error("Authorization header missing");

  const token = authHeader;
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    return decoded; // e.g. { id: "user_id", iat: ..., exp: ... }
  } catch (err) {
    throw new Error("Invalid or expired token");
  }
};

module.exports = {
  hashPassword,
  comparePassword,
  generateToken,
  authenticate,
};
