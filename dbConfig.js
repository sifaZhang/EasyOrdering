const { Pool } = require('pg');

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false
  }
});

// 测试连接（PostgreSQL 正确写法）
pool.connect()
  .then(client => {
    console.log('Connected to the database');
    client.release(); // 释放连接
  })
  .catch(err => {
    console.error('Database connection error:', err.stack);
  });

module.exports = pool;
