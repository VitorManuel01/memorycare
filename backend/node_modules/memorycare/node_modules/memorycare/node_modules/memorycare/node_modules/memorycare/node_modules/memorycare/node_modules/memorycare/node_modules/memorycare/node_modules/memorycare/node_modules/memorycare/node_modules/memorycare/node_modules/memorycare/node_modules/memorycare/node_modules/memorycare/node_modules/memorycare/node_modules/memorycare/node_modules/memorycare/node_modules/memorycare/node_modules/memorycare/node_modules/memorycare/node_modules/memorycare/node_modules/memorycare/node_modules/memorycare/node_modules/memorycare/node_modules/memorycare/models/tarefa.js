'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Tarefa extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Tarefa.init({
    id_dependente_FK: DataTypes.INTEGER,
    titulo: DataTypes.STRING,
    texto: DataTypes.TEXT,
    horario: DataTypes.DATE,
    status: DataTypes.STRING,
    tarefa_se_repete: DataTypes.BOOLEAN,
    criado_em: DataTypes.DATE
  }, {
    sequelize,
    modelName: 'Tarefa',
  });
  return Tarefa;
};