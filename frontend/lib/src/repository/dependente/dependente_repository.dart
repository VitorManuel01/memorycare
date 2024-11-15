import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/dependente.dart';
import 'package:memorycare/src/views/home/HomePage.dart';

class DependenteRepository extends GetxController {
  static DependenteRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String?> obterUidUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  createDependente(Dependente dependente) async {

    String? uid = await obterUidUsuario();

    // Verifica se o usuário está autenticado
    if (uid == null) {
      Get.snackbar(
        "Erro",
        "Usuário não autenticado.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return; // Retorna para não tentar salvar o dependente
    }

    // Tenta registrar o dependente no Firestore
    try {
      await _db
          .collection("cuidadores/$uid/dependente")
          .add(dependente.toJson())
          .whenComplete(() {
            // Exibe mensagem de sucesso e redireciona para a HomePage
            Get.snackbar(
              "Sucesso",
              "Dependente cadastrado com sucesso",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green,
            );
            Get.offAll(() => const HomePage());
          });
    } catch (error, stackTrace) {
      // Exibe erro caso ocorra uma falha na operação
      print("Error: $error");
      print("StackTrace: $stackTrace");
      Get.snackbar(
        "Erro",
        "Erro ao registrar dependente, por favor tente novamente",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}

