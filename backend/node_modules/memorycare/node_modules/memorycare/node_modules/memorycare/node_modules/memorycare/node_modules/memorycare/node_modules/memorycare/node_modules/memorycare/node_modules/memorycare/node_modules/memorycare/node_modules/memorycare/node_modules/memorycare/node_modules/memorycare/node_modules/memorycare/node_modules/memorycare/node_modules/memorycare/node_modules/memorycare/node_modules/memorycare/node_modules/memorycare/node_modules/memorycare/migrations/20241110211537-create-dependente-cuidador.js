'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('DependenteCuidadors', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      dependenteId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'Dependente', // Nome da tabela Dependentes
          key: 'id'
        },
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
      },
      cuidadorId: {
        type: Sequelize.STRING,
        references: {
          model: 'Cuidador', // Nome da tabela Cuidadors
          key: 'firebaseUid'
        },
        onUpdate: 'CASCADE',
        onDelete: 'CASCADE'
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
    await queryInterface.dropTable('DependenteCuidadors');
  }
};