import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/tarefa.dart';
import 'package:memorycare/src/views/home/HomePage.dart';

class TarefasRepository extends GetxController {
  static TarefasRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String?> obterUidUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future<String?> obterIdDependente(String uidCuidador) async {
    // Busca o primeiro dependente do cuidador
    QuerySnapshot dependenteSnapshot = await _db
        .collection("cuidadores")
        .doc(uidCuidador)
        .collection("dependente")
        .get();

    if (dependenteSnapshot.docs.isNotEmpty) {
      // Retorna o ID do primeiro documento na coleção `dependente`
      return dependenteSnapshot.docs.first.id;
    } else {
      return null;
    }
  }

  createTarefa(Tarefa tarefa) async {
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

    String? idDependente = await obterIdDependente(uid);
    if (idDependente == null) {
      throw Exception("Dependente não encontrado para o cuidador");
    }
    // Tenta registrar a tarefa no Firestore
    try {
      await _db
          .collection("cuidadores/$uid/dependente/$idDependente/tarefas")
          .add(tarefa.toJson())
          .whenComplete(() {
        // Exibe mensagem de sucesso e redireciona para a HomePage
        Get.snackbar(
          "Sucesso",
          "Tarefa registrada com sucesso",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
        Get.to(() => const HomePage());
      });
    } catch (error, stackTrace) {
      // Exibe erro caso ocorra uma falha na operação
      print("Error: $error");
      print("StackTrace: $stackTrace");
      Get.snackbar(
        "Erro",
        "Erro ao registrar tarefa, por favor tente novamente",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }


  Future<Stream<List<Tarefa>>> getTarefas() async {

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

    }

    String? idDependente = await obterIdDependente(uid!);
    if (idDependente == null) {
      throw Exception("Dependente não encontrado para o cuidador");
    }

    return _db
        .collection('cuidadores/$uid/dependente/$idDependente/tarefas')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Tarefa.fromFirestore(doc))
              .toList();
        });
  }




}
