import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/cuidadores.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';

import '../repository/authentication_repository/cuidador_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Controllers das linhas de texto para pegar os dados deles
  final nomeCompleto = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final telefone = TextEditingController();
  final idade = TextEditingController();
  final parentescoFuncao = TextEditingController();
  var obscureText = true.obs;

  final cuidadorRepo = Get.put(CuidadorRepository());

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  Future<void> criarCuidador(Cuidadores cuidador) async {
    await cuidadorRepo.createCuidador(cuidador);
  }

  //Função pra ser usada no widget de registro
  Future<void> registrarUsuario(String email, String senha) async {
    try {
      // registra o usuário no Firebase
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: senha);
    } on FirebaseAuthException catch (e) {
      // Tratar erros específicos de autenticação
      if (e.code == 'email-already-in-use') {
        print("Erro: E-mail já está em uso.");
        Get.snackbar(
          "Erro",
          "Este e-mail já está em uso. Por favor, escolha outro.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      } else {
        print("Erro no registro: ${e.message}");
        Get.snackbar(
          "Erro",
          "Erro inesperado ao registrar o usuário. Tente novamente mais tarde.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      // Tratar outros tipos de erro não especificados
      print("Erro inesperado: ${e.toString()}");
      Get.snackbar(
        "Erro",
        "Erro inesperado. Tente novamente.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  void autenticarPorTelefone(String telefone) {
    AuthenticationRepository.instance.phoneNumberAuthentication(telefone);
  }
}




  // Future<void> registerUserToBackend(String token, String firebaseUid) async {
  //   final response = await http.post(
  //     Uri.parse(
  //         'http://10.0.2.2:3000/memorycareapi/register'), // Corrige a porta se necessário
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode({
  //       'firebaseUid': firebaseUid,
  //       'nome': nomeCompleto.text,
  //       'email': email.text,
  //       'telefone': telefone.text,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     print('Usuário registrado no backend com sucesso');
  //   } else {
  //     print('Erro ao registrar usuário no backend: ${response.body}');
  //   }
  // }

    // // Depois pega o UID do usuário registrado e o token para autenticação no backend
    // final user = userCredential.user; // O usuário foi registrado com sucesso
    // print(user);
    // Get.to(() => const SignUpPageComplimentary());
    // if (user != null) {
    //   final token = await user.getIdToken(); // Obtém o token de autenticação
    //   if (token != null) {
    //     await registerUserToBackend(token, user.uid); // Envia o token e o UID para o backend
    //   } else {
    //     print("Token não obtido.");
    //   }
    // } else {
    //   print("Usuário não registrado corretamente.");
    // }