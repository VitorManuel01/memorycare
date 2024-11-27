import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/dependente.dart';
import 'package:memorycare/src/repository/dependente/dependente_repository.dart';

class DependenteController extends GetxController {
  static DependenteController get instance => Get.find();

  final dependenteRepo = Get.put(DependenteRepository());

  final nome = TextEditingController();
  final idade = TextEditingController();
  final contatoDeEmergencia = TextEditingController();
  final telefone = TextEditingController();
  final endereco = TextEditingController();
  final cuidadorPrincipal = TextEditingController();



  createDependente(Dependente dependente) async {
    await dependenteRepo.createDependente(dependente);
  }

  Future<Dependente> getDependente() async {
    return await dependenteRepo.getDependente();
  }

    editarDependente(Dependente dependente) {
    dependenteRepo.editarDependente(dependente);
  }

}
