import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/cuidadores.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';
import 'package:http/http.dart' as http;

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

  final cuidadorRepo = Get.put(CuidadorRepository());

  void limparControladores() {
    nomeCompleto.clear();
    email.clear();
    senha.clear();
    telefone.clear();
    idade.clear();
    parentescoFuncao.clear();
  }

  @override
  void onClose() {
    nomeCompleto.dispose();
    email.dispose();
    senha.dispose();
    telefone.dispose();
    idade.dispose();
    parentescoFuncao.dispose();
    super.onClose();
  }
  var exibirFormComplementar = false.obs;

  // Função para avançar para o formulário complementar
  void avancarParaFormularioComplementar() {
    exibirFormComplementar.value = true;
  }

  // Função para voltar ao formulário inicial, se necessário
  void voltarParaFormularioInicial() {
    exibirFormComplementar.value = false;
  }

  Future<void> criarCuidador(Cuidadores cuidador) async {
    await cuidadorRepo.createCuidador(cuidador);
  }

  //Função pra ser usada no widget de registro
  void registrarUsuario(String email, String senha) async {
    try {
      // Primeiro registra o usuário no Firebase
      await AuthenticationRepository.instance
          .createUserWithEmailAndPassword(email, senha);

      // Depois pega o UID do usuário registrado e o token para autenticação no backend
      final user = AuthenticationRepository.instance.firebaseUser.value;
      print(user);
      if (user != null) {
        final token = await user.getIdToken();
        await registerUserToBackend(token!, user.uid);
      }
    } catch (e) {
      print("EXCEPTION - ${e.toString()}");
    }
  }

  Future<void> registerUserToBackend(String token, String firebaseUid) async {
    final response = await http.post(
      Uri.parse(
          'http://10.0.2.2:3000/memorycareapi/register'), // Corrige a porta se necessário
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firebaseUid': firebaseUid,
        'nome': nomeCompleto.text,
        'email': email.text,
        'telefone': telefone.text,
      }),
    );

    if (response.statusCode == 200) {
      print('Usuário registrado no backend com sucesso');
    } else {
      print('Erro ao registrar usuário no backend: ${response.body}');
    }
  }

  void autenticarPorTelefone(String telefone) {
    AuthenticationRepository.instance.phoneNumberAuthentication(telefone);
  }
}
