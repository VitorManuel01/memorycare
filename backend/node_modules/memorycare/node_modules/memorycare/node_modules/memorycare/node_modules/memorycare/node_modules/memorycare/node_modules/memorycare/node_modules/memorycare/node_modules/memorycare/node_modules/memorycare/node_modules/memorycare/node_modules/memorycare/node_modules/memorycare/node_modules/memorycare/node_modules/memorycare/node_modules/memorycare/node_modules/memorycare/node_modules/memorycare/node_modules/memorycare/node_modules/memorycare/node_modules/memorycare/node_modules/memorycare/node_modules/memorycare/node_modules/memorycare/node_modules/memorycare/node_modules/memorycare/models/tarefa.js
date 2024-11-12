// 'use strict';
// const {
//   Model
// } = require('sequelize');
// module.exports = (sequelize, DataTypes) => {
//   class Tarefa extends Model {
//     /**
//      * Helper method for defining associations.
//      * This method is not a part of Sequelize lifecycle.
//      * The `models/index` file will call this method automatically.
//      */
//     static associate(models) {
//       // define association here
//     }
//   }
//   Tarefa.init({
//     id_dependente_FK: DataTypes.INTEGER,
//     titulo: DataTypes.STRING,
//     texto: DataTypes.TEXT,
//     horario: DataTypes.DATE,
//     status: DataTypes.STRING,
//     tarefa_se_repete: DataTypes.BOOLEAN,
//   }, {
//     sequelize,
//     modelName: 'Tarefa',
//   });
//   return Tarefa;
// };

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Tarefa = sequelize.define('Tarefa', {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER
  },
  id_dependente_FK: {
    type: DataTypes.INTEGER,
    references: {
      model: 'Dependente',
      key: 'id'
    },
    onUpdate: 'CASCADE',
    onDelete: 'SET NULL'
  },
  titulo: {
    type: DataTypes.STRING(100), // Limita o tamanho do título a 100 caracteres
    allowNull: false
  },
  texto: {
    type: DataTypes.TEXT,
    allowNull: true // Texto pode ser opcional
  },
  horario: {
    type: DataTypes.TIME, // Use DataTypes.TIME se precisar apenas de horas
    allowNull: false
  },
  status: {
    type: DataTypes.ENUM('pendente','concluída'), // Status com valores predefinidos
    defaultValue: 'pendente'
  },
  tarefa_se_repete: {
    type: DataTypes.BOOLEAN,
    defaultValue: false // Define valor padrão como não-repetitiva
  }
}, {
  timestamps: true, // Adiciona createdAt e updatedAt automaticamente
  createdAt: 'criado_em', // Renomeia o campo para "criado_em"
  updatedAt: false, // Desativa o updatedAt se não for necessário
  tableName: 'Tarefas' // Define o nome da tabela explicitamente
});

module.exports = Tarefa;