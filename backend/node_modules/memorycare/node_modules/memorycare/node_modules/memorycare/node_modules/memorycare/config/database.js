const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('memorycare', 'Budah', 'VitorSQLDeusVult', {
    host: '127.0.0.1',
    dialect: 'mysql',
    port: '3306',
    
    // configuração necessária para evitar o erro ECONNRESET
    dialectOptions: {
        ssl: {
            require: true,
            rejectUnauthorized: false,
        },
    },
    logging: console.log,
});

module.exports = sequelize;