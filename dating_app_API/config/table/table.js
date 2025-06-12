const pool = require("../database/postgreSQL");

const queryText = `
-- USERS
CREATE TABLE IF NOT EXISTS users (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash TEXT NOT NULL,
  gender VARCHAR(50),
  age INTEGER CHECK (age >= 18),
  location VARCHAR(255),
  bio TEXT,
  occupation VARCHAR(255),
  instagram_handle VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
); 

-- USER PREFERENCES
CREATE TABLE IF NOT EXISTS user_preferences (
  id VARCHAR(255) PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  type_of_relationship TEXT,
  interested_gender TEXT,
  interested_religion TEXT,
  interested_age_min INT,
  interested_age_max INT,
  max_distance INT,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- PHOTOS
CREATE TABLE IF NOT EXISTS photos (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  user_id VARCHAR(255) NOT NULL,
  url TEXT NOT NULL,
  is_main BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- LIKES
CREATE TABLE IF NOT EXISTS likes (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  from_user_id VARCHAR(255) NOT NULL,
  to_user_id VARCHAR(255) NOT NULL,
  liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (from_user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (to_user_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE (from_user_id, to_user_id)
);

-- MATCHES
CREATE TABLE IF NOT EXISTS matches (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  user1_id VARCHAR(255) NOT NULL,
  user2_id VARCHAR(255) NOT NULL,
  matched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  last_message_at TIMESTAMP,
  is_active BOOLEAN DEFAULT TRUE,
  blocked_by_user_id VARCHAR(255),
  FOREIGN KEY (user1_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (user2_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (blocked_by_user_id) REFERENCES users(id),
  UNIQUE (user1_id, user2_id)
);

-- REPORTS
CREATE TABLE IF NOT EXISTS reports (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  reporter_id VARCHAR(255) NOT NULL,
  reported_id VARCHAR(255) NOT NULL,
  reason TEXT,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (reporter_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (reported_id) REFERENCES users(id) ON DELETE CASCADE
);

-- BLOCKS
CREATE TABLE IF NOT EXISTS blocks (
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  blocker_id VARCHAR(255) NOT NULL,
  blocked_id VARCHAR(255) NOT NULL,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (blocker_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (blocked_id) REFERENCES users(id) ON DELETE CASCADE,
  UNIQUE (blocker_id, blocked_id)
);

-- PERSONALITY
CREATE TABLE IF NOT EXISTS personality (
  user_id VARCHAR(255) PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  personality_type VARCHAR(10),
  zodiac_sign VARCHAR(20),
  political_view VARCHAR(50),
  love_language VARCHAR(50),
  humor_style VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- LIFESTYLE
CREATE TABLE IF NOT EXISTS lifestyle (
  user_id VARCHAR(255) PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
  smoking BOOLEAN,
  drinking BOOLEAN,
  pets BOOLEAN,
  wants_kids BOOLEAN,
  dietary_preference VARCHAR(50),
  relationship_goal VARCHAR(50),
  fitness_level VARCHAR(50),
  religion VARCHAR(50),
  sleep_schedule VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
`;

const createTables = async () => {
  try {
    await pool.query(queryText);
    console.log("Tables created successfully.");
  } catch (error) {
    console.error("Error creating tables:", error);
  }
};

module.exports = createTables;
