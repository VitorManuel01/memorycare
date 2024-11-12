'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class DependenteCuidador extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  DependenteCuidador.init({
    dependenteId: DataTypes.INTEGER,
    cuidadorId: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'DependenteCuidador',
  });
  return DependenteCuidador;
};