const express = require('express');
const router = express.Router();
const Cuidador = require('../models/cuidador'); 
const admin = require('firebase-admin');

// Middleware para verificar o token JWT do Firebase
const authenticateToken = async (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) return res.sendStatus(401); // Não autenticado

  try {
    const decodedToken = await admin.auth().verifyIdToken(token);
    req.user = decodedToken; // Adiciona o usuário ao request
    next();
  } catch (error) {
    res.sendStatus(403); // Token inválido
  }
};

// Rota de registro para salvar o cuidador no banco de dados
router.post('/register', authenticateToken, async (req, res) => {
  const { firebaseUid, nome, email, telefone } = req.body;

  try {
    // Verifica se o usuário já existe
    let cuidador = await Cuidador.findOne({ where: { firebaseUid } });

    if (!cuidador) {
      // Cria um novo registro no banco de dados
      cuidador = await Cuidador.create({
        firebaseUid,
        nome,
        email,
        telefone,
        // outros campos, se necessário
      });
    }

    res.status(201).json({
      message: 'Registro bem-sucedido',
      user: cuidador,
    });
  } catch (error) {
    res.status(500).json({ message: 'Erro no registro', error: error.message });
  }
});

module.exports = router;
