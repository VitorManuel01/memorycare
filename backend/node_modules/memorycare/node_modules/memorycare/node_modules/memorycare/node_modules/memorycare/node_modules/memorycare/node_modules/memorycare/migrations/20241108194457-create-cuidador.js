'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Cuidador', {
      firebaseUid: {
        allowNull: false,
        primaryKey: true,
        type: Sequelize.STRING
      },
      nome: {
        type: Sequelize.STRING
      },
      idade: {
        type: Sequelize.INTEGER
      },
      parentesco_funcao: {
        type: Sequelize.STRING
      },
      email: {
        type: Sequelize.STRING,
        unique: true,
      },
      telefone: {
        type: Sequelize.STRING
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
    await queryInterface.dropTable('Cuidador');
  }
};