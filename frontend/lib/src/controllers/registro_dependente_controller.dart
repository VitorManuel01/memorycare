import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/dependente.dart';
import 'package:memorycare/src/repository/authentication_repository/dependente_repository.dart';

class RegistroDependenteController extends GetxController {
  static RegistroDependenteController get instance => Get.find();

  final nome = TextEditingController();
  final idade = TextEditingController();
  final contatoDeEmergencia = TextEditingController();
  final telefone = TextEditingController();
  final endereco = TextEditingController();
  final cuidadorPrincipal = TextEditingController();

  final dependenteRepo = Get.put(DependenteRepository());

  createDependente(Dependente dependente) async {
    await dependenteRepo.createDependente(dependente);
  }
}
