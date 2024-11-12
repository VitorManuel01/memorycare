'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Dependente extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Dependente.init({
    nome: DataTypes.STRING,
    idade: DataTypes.INTEGER,
    contato_emergencia: DataTypes.STRING,
    observacoes: DataTypes.STRING,
    residencia: DataTypes.STRING,
    cuidador_ID: DataTypes.INTEGER
  }, {
    sequelize,
    modelName: 'Dependente',
  });
  return Dependente;
};

const { DataTypes } = require('sequelize');
const sequelize = require('../config/database'); // Certifique-se de que o caminho está correto

const Dependente = sequelize.define('Dependente', {
  id: {
    allowNull: false,
    autoIncrement: true,
    primaryKey: true,
    type: DataTypes.INTEGER
  },
  nome: {
    type: DataTypes.STRING
  },
  idade: {
    type: DataTypes.INTEGER
  },
  contato_emergencia: {
    type: DataTypes.STRING
  },
  observacoes: {
    type: DataTypes.STRING
  },
  residencia: {
    type: DataTypes.STRING
  },
});

Dependente.associate = function(models) {
  Dependente.belongsToMany(models.Cuidador, {
    through: 'DependenteCuidador', // Tabela de junção
    as: 'cuidador',              // Alias para acessar cuidadores de um dependente
    foreignKey: 'dependenteId',    // Chave estrangeira referente ao Dependente
  });
};



module.exports = Dependente;