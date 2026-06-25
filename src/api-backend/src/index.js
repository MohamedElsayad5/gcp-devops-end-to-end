const express = require('express');
const { Pool } = require('pg');
const redis = require('redis');

const app = express();
const port = 5000;

//  (PostgreSQL)
const pgClient = new Pool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'postgres',
  password: process.env.DB_PASSWORD || 'password',
  database: process.env.DB_NAME || 'mydb',
  port: 5432,
});

// Caching (Redis)
const redisClient = redis.createClient({
  url: `redis://${process.env.REDIS_HOST || 'localhost'}:6379`
});
redisClient.connect().catch(console.error);

app.get('/api/data', async (req, res) => {
  try {
    // 1.(Redis)؟
    const cachedData = await redisClient.get('products');
    if (cachedData) {
      return res.json({ source: 'cache', data: JSON.parse(cachedData) });
    }

    // 2.Database
    const dbResult = await pgClient.query('SELECT * FROM products');
    
    // 3. (Redis) Cache the result for 60 seconds
    await redisClient.setEx('products', 60, JSON.stringify(dbResult.rows));

    res.json({ source: 'database', data: dbResult.rows });
  } catch (err) {
    res.status(500).send(err.message);
  }
});

app.listen(port, () => console.log(`Backend API listening on port ${port}`));