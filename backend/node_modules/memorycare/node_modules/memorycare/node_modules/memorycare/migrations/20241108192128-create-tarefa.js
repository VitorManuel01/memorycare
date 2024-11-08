'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Tarefas', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      id_dependente_FK: {
        type: Sequelize.INTEGER,
          references:{
          model: 'Dependente',
          key: 'id'
        },
        onUpdate: 'CASCADE',
        onDelete: 'SET NULL'
      },
      titulo: {
        type: Sequelize.STRING
      },
      texto: {
        type: Sequelize.TEXT
      },
      horario: {
        type: Sequelize.DATE
      },
      status: {
        type: Sequelize.STRING
      },
      tarefa_se_repete: {
        type: Sequelize.BOOLEAN
      },
      criado_em: {
        type: Sequelize.DATE
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
    await queryInterface.dropTable('Tarefas');
  }
};