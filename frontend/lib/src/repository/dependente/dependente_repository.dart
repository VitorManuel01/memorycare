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

  Future<Dependente> getDependente() async {
    String? uid = await obterUidUsuario();

    if (uid == null) {
      Get.snackbar(
        "Erro",
        "Usuário não autenticado.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      throw Exception("Usuário não autenticado");
    }

    try {
      // Obtém o único documento na subcoleção.
      QuerySnapshot querySnapshot = await _db
          .collection('cuidadores/$uid/dependente')
          .limit(1) // Garante que apenas 1 documento será obtido.
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;
        return Dependente.fromFirestore(doc);
      } else {
        throw Exception("Dependente não encontrado");
      }
    } catch (e) {
      throw Exception("Erro ao obter Dependente: $e");
    }
  }

    editarDependente(Dependente dependente) async {
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
      return;
    }

        String? idDependente = await obterIdDependente(uid);
    if (idDependente == null) {
      throw Exception("Dependente não encontrado para o cuidador");
    }

    try {
      await _db
          .collection('cuidadores/$uid/dependente/')
          .doc(idDependente)
          .update({
        'NomeCompleto': dependente.nome,
        'Idade': dependente.idade,
        'ContatoEmergencia': dependente.contatoEmergencia,
        'Telefone': dependente.telefone,
        'Residencia': dependente.endereco,
        'CuidadorPrincipal': dependente.cuidadorPrincipal,
      });
      Get.snackbar(
        "Sucesso",
        "Dependente editado com sucesso!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        "Erro",
        "Não foi possível editar as informações do dependente: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

}
