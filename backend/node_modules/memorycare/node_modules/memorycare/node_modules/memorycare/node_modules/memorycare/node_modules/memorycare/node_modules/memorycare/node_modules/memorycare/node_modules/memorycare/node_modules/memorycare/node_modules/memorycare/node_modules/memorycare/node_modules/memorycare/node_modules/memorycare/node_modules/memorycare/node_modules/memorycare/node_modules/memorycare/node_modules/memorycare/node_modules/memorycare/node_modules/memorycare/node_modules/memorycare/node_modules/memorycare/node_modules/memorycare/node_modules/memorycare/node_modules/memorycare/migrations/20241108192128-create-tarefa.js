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
        references: {
          model: 'Dependente',
          key: 'id'
        },
        onUpdate: 'CASCADE',
        onDelete: 'SET NULL'
      },
      titulo: {
        type: Sequelize.STRING(100), // Limita o título a 100 caracteres
        allowNull: false
      },
      texto: {
        type: Sequelize.TEXT,
        allowNull: true
      },
      horario: {
        type: Sequelize.TIME,
        allowNull: false
      },
      status: {
        type: Sequelize.ENUM('pendente','concluída'), // Define valores para status
        defaultValue: 'pendente'
      },
      tarefa_se_repete: {
        type: Sequelize.BOOLEAN,
        defaultValue: false
      },
      criado_em: {
        type: Sequelize.DATE,
        allowNull: false,
        defaultValue: Sequelize.NOW // Define a data de criação para o momento atual
      }
    });
  },
  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('Tarefas');
  }
};
