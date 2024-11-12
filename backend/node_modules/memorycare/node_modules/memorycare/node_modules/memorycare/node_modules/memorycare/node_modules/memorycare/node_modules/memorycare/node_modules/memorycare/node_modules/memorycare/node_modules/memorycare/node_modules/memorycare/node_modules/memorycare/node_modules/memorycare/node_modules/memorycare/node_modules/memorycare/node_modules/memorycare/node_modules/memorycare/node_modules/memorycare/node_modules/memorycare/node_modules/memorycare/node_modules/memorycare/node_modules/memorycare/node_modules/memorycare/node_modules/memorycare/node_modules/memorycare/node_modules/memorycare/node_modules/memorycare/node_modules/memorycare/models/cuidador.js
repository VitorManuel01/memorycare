'use strict';
const {
  Model
} = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Cuidador extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  Cuidador.init({
    nome: DataTypes.STRING,
    idade: DataTypes.INTEGER,
    parentesco_funcao: DataTypes.STRING,
    email: DataTypes.STRING,
    telefone: DataTypes.STRING,
    senha: DataTypes.STRING
  }, {
    sequelize,
    modelName: 'Cuidador',
    freezeTableName: true,
  });
  return Cuidador;
};

'use strict';
const { DataTypes } = require('sequelize');
const sequelize = require('../config/database'); // Certifique-se de que o caminho está correto

const Cuidador = sequelize.define('Cuidador', {
  firebaseUid: {
    allowNull: false,
    primaryKey: true,
    type: DataTypes.STRING
  },
  nome: {
    type: DataTypes.STRING
  },
  idade: {
    type: DataTypes.INTEGER
  },
  parentesco_funcao: {
    type: DataTypes.STRING
  },
  email: {
    type: DataTypes.STRING,
    unique: true,
  },
  telefone: {
    type: DataTypes.STRING
  }
}, {
  
  freezeTableName: true, 
});

// Associações (se houver)
Cuidador.associate = function(models) {
  Cuidador.belongsToMany(models.Dependente, {
    through: 'DependenteCuidador', // Tabela de junção
    as: 'dependente',              // Alias para acessar dependentes de um cuidador
    foreignKey: 'cuidadorId',      // Chave estrangeira referente ao Cuidador
  });
};

module.exports = Cuidador;
