'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Dependente', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      nome: {
        type: Sequelize.STRING
      },
      idade: {
        type: Sequelize.INTEGER
      },
      contato_emergencia: {
        type: Sequelize.STRING
      },
      observacoes: {
        type: Sequelize.STRING
      },
      residencia: {
        type: Sequelize.STRING
      },
      cuidador_ID: {
        type: Sequelize.STRING,
        references:{
          model: 'Cuidador',
          key: 'firebaseUid'
        },
        onUpdate: 'CASCADE',
        onDelete: 'SET NULL'
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Dependente');
  }
};