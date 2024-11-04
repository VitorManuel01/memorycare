import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //Controllers das linhas de texto para pegar os dados deles
  final nomeCompleto = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final telefone = TextEditingController();

  //Função pra ser usada no widget de registro
  void registrarUsuario(String email, String senha) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, senha);
  }

  void autenticarPorTelefone(String telefone) {
    AuthenticationRepository.instance.phoneNumberAuthentication(telefone);
  }
}
