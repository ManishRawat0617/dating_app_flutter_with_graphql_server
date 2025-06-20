const express = require("express");
const router = express.Router();
const axios = require("axios");
const pool = require("../config/database/postgreSQL");

// POST /api/lifestyle
router.post("/", async (req, res) => {
  const user = req.body;

  try {
    // Step 1: Call Python clustering API
    const response = await axios.post("http://localhost:5001/assign-cluster", user);
    const cluster = response.data.cluster;

    // Step 2: Save to PostgreSQL
    const insertQuery = `
      INSERT INTO lifestyle (
        user_id, smoking, drinking, pets, wants_kids,
        dietary_preference, relationship_goal, fitness_level,
        religion, sleep_schedule, cluster
      ) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)
      RETURNING *;
    `;

    const values = [
      user.user_id,
      user.smoking,
      user.drinking,
      user.pets,
      user.wants_kids,
      user.dietary_preference,
      user.relationship_goal,
      user.fitness_level,
      user.religion,
      user.sleep_schedule,
      cluster,
    ];

    const result = await pool.query(insertQuery, values);
    return res.status(201).json({
      message: "User saved with cluster",
      data: result.rows[0],
    });
  } catch (err) {
    console.error("Error:", err.message);
    return res.status(500).json({ error: "Failed to save user" });
  }
});

module.exports = router;
