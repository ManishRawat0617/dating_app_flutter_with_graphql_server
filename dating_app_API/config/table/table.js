const pool = require("../database/postgreSQL");

const queryText = `
--USER
CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    gender VARCHAR(50),
    age INTEGER CHECK (age >= 18), -- assuming minimum age requirement
    location VARCHAR(255), -- can be city name or geo-coordinates string
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
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

-- PEROSNALITY
CREATE TABLE IF NOT EXISTS personality (
    user_id VARCHAR(255) PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    personality_type VARCHAR(10),           -- e.g., MBTI like "INTJ"
    zodiac_sign VARCHAR(20),                -- Optional: if used in matching
    political_view VARCHAR(50),             -- e.g., Liberal, Conservative
    love_language VARCHAR(50),              -- e.g., "Acts of Service"
    humor_style VARCHAR(50),                -- e.g., Sarcastic, Dry
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- LIFESTYLE
CREATE TABLE IF NOT EXISTS lifestyle (
    user_id VARCHAR(255) PRIMARY KEY REFERENCES users(id) ON DELETE CASCADE,
    smoking BOOLEAN,               -- true = smokes, false = doesn't
    drinking BOOLEAN,
    pets BOOLEAN,                  -- true = owns pets or likes them
    wants_kids BOOLEAN,
    dietary_preference VARCHAR(50),    -- e.g., Vegan, Non-Veg, Halal
    relationship_goal VARCHAR(50),     -- e.g., Casual, Long-term, Marriage
    fitness_level VARCHAR(50),         -- e.g., Active, Moderate, Not active
    religion VARCHAR(50),
    sleep_schedule VARCHAR(50),        -- e.g., Night Owl, Early Riser
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

`;

const createTables = async () => {
  try {
    await pool.query(queryText);
    console.log("Tables created successfully.");
  } catch (error) {
    console.log("Error creating tables:", error);
  }
};

module.exports = createTables;
