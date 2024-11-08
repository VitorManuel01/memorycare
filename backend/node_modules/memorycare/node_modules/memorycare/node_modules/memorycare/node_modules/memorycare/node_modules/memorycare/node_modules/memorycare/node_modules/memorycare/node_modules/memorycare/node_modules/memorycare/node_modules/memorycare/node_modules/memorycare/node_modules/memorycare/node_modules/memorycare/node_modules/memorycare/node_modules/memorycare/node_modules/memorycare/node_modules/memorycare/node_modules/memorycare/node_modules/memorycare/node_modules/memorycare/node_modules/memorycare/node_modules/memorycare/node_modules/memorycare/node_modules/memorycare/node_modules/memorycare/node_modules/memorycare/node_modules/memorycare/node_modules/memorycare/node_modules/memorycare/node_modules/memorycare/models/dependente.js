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