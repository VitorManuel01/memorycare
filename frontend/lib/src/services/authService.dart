import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final String backendUrl = "http://localhost:3000"; // URL do backend em Node.js

  Future<void> login(String email, String password) async {
    try {
      // Login no Firebase
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Obtém o ID Token do Firebase
      String? idToken = await userCredential.user?.getIdToken();

      if (idToken != null) {
        // Envia o token para o backend
        final response = await http.post(
          Uri.parse('$backendUrl/login'),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $idToken", // Token do Firebase no cabeçalho
          },
        );

        if (response.statusCode == 200) {
          print("Login no backend com sucesso");
        } else {
          print("Erro ao fazer login no backend: ${response.body}");
        }
      }
    } catch (e) {
      print("Erro ao fazer login no Firebase: $e");
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut(); // Logout no Firebase
  }
}
