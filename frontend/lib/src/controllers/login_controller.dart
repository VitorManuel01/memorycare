import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //Controllers das linhas de texto para pegar os dados deles
  final email = TextEditingController();
  final senha = TextEditingController();
  final telefone = TextEditingController();
  var obscureText = true.obs;

  void login(String email, String senha) {
    AuthenticationRepository.instance
        .loginUserWithEmailAndPassword(email, senha);
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }


  void autenticarPorTelefone(String telefone) {
    AuthenticationRepository.instance.phoneNumberAuthentication(telefone);
  }
}
