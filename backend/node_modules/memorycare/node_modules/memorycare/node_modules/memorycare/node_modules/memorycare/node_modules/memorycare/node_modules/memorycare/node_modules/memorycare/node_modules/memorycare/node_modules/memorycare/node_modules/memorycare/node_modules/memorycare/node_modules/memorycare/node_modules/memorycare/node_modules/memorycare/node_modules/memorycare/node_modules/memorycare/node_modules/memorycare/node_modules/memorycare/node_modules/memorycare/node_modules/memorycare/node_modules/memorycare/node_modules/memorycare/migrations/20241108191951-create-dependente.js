// 'use strict';
// /** @type {import('sequelize-cli').Migration} */
// module.exports = {
//   async up(queryInterface, Sequelize) {
//     await queryInterface.createTable('Dependentes', {
//       id: {
//         allowNull: false,
//         autoIncrement: true,
//         primaryKey: true,
//         type: Sequelize.INTEGER
//       },
//       nome: {
//         type: Sequelize.STRING
//       },
//       idade: {
//         type: Sequelize.INTEGER
//       },
//       contato_emergencia: {
//         type: Sequelize.STRING
//       },
//       observacoes: {
//         type: Sequelize.STRING
//       },
//       residencia: {
//         type: Sequelize.STRING
//       },
//       cuidador_ID: {
//         type: Sequelize.INTEGER
//       },
//       createdAt: {
//         allowNull: false,
//         type: Sequelize.DATE
//       },
//       updatedAt: {
//         allowNull: false,
//         type: Sequelize.DATE
//       }
//     });
//   },
//   async down(queryInterface, Sequelize) {
//     await queryInterface.dropTable('Dependentes');
//   }
// };

'use strict';
/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Dependente', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      nome: {
        type: Sequelize.STRING
      },
      idade: {
        type: Sequelize.INTEGER
      },
      contato_emergencia: {
        type: Sequelize.STRING
      },
      observacoes: {
        type: Sequelize.STRING
      },
      residencia: {
        type: Sequelize.STRING
      },
      cuidador_ID: {
        type: Sequelize.INTEGER,
        references:{
          model: 'Cuidador',
          key: 'id'
        },
        onUpdate: 'CASCADE',
        onDelete: 'SET NULL'
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
    await queryInterface.dropTable('Dependente');
  }
};