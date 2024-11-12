const express = require('express')
const bp = require('body-parser')
const multer = require('multer')
const admin = require('firebase-admin');

const app = express()
app.use(bp.urlencoded({ extended: true }))
app.use(bp.json())
app.use(express.static('public'));


let dependentes = [];
let tarefas = [];
let cuidadores = [];
const Dependente = require('./models/dependente');
const Cuidador = require('./models/cuidador');
const Tarefa = require('./models/tarefa');

// Inicializa o Firebase Admin
const serviceAccount = require('./config/memory-care-64711-firebase-adminsdk-ja1bm-e1ddc49172.json');
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

app.use(express.json());

// Middleware para verificar o token
const authenticateToken = async (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) return res.sendStatus(401);

  try {
    const decodedToken = await admin.auth().verifyIdToken(token);
    req.user = decodedToken; // Armazena o token decodificado no request

    // Registra ou atualiza o usuário no banco de dados
    await registerOrUpdateUser(decodedToken.uid, decodedToken.email);

    next();
  } catch (error) {
    res.sendStatus(403); // Token inválido
  }
};


app.post('/login', authenticateToken, (req, res) => {
  // Usuário autenticado pelo Firebase, controle adicional pode ser adicionado aqui
  res.json({ message: 'Login bem-sucedido no backend!', user: req.user });
});

const registerRouter = require('./routes/register');
app.use('/memorycareapi', registerRouter);

const port = 3000;

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

// bibliotecas de geofencing
// https://www.npmjs.com/package/geolib
// https://www.npmjs.com/package/geofencing
// https://www.npmjs.com/package/nodejs-geolocation