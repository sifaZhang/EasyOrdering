// dbConfig.js - PostgreSQL 版本（支持 Neon）
const { Pool } = require('pg');

// 优先使用完整的连接字符串
let poolConfig;

if (process.env.DATABASE_URL) {
    // 使用 Neon 提供的完整连接字符串
    poolConfig = {
        connectionString: process.env.DATABASE_URL,
        ssl: process.env.NODE_ENV === 'production' 
            ? { rejectUnauthorized: false } 
            : false
    };
} else {
    // 使用分离的配置
    poolConfig = {
        host: process.env.DB_HOST || 'localhost',
        port: process.env.DB_PORT || 5432,
        user: process.env.DB_USER || 'postgres',
        password: process.env.DB_PASSWORD || 'password',
        database: process.env.DB_NAME || 'easyordering',
        ssl: process.env.NODE_ENV === 'production' 
            ? { rejectUnauthorized: false } 
            : false
    };
}

const pool = new Pool(poolConfig);

// 保持与原有 conn 相同的接口
const conn = {
    query: (sql, params, callback) => {
        // 处理参数格式
        if (typeof params === 'function') {
            callback = params;
            params = undefined;
        }
        
        // 转换 MySQL 的 ? 为 PostgreSQL 的 $1, $2...
        let query = sql;
        if (params && params.length > 0) {
            let index = 1;
            query = sql.replace(/\?/g, () => `$${index++}`);
        }
        
        return pool.query(query, params)
            .then(result => {
                if (callback) {
                    // 模拟 MySQL 的 callback 格式 (error, results, fields)
                    callback(null, result.rows, null);
                }
                return result;
            })
            .catch(err => {
                if (callback) {
                    callback(err, null, null);
                }
                throw err;
            });
    },
    
    // 获取连接（用于事务）
    getClient: async () => {
        return await pool.connect();
    },
    
    // 支持事务
    begin: async (client) => {
        await client.query('BEGIN');
    },
    
    commit: async (client) => {
        await client.query('COMMIT');
        client.release();
    },
    
    rollback: async (client) => {
        await client.query('ROLLBACK');
        client.release();
    }
};

module.exports = conn;