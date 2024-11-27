import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/cuidadoresSucundarios.dart';
import 'package:memorycare/src/views/home/HomePage.dart';

class CuidadorSecundarioRepository extends GetxController {
  static CuidadorSecundarioRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Função assíncrona para obter o UID do usuário autenticado
  Future<String?> obterUidUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      return uid;
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

  createCuidadorSecundadrio(CuidadoresSecundarios cuidadorSecundario) async {
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

    try {
      await _db
          .collection(
              "cuidadores/$uid/dependente/$idDependente/cuidadoresSecundarios")
          .add(cuidadorSecundario.toJson())
          .whenComplete(() {
        // Exibe mensagem de sucesso e redireciona para a HomePage
        Get.snackbar(
          "Sucesso",
          "Cuidador Secundário registrada com sucesso",
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
        "Erro ao registrar cuidador secundario, por favor tente novamente",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  Future<Stream<List<CuidadoresSecundarios>>> getCuidadoresSecundarios() async {
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

    final stream = _db
        .collection(
            'cuidadores/$uid/dependente/$idDependente/cuidadoresSecundarios')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CuidadoresSecundarios.fromFirestore(doc))
            .toList());

    return Future.value(stream);
  }

  Future<CuidadoresSecundarios> getCuidadorSecundario(
      String idCuidadorSecundario) async {
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
      throw Exception("Usuário não autenticado");
    }

    String? idDependente = await obterIdDependente(uid);
    if (idDependente == null) {
      throw Exception("Dependente não encontrado para o cuidador principal");
    }

    try {
      DocumentSnapshot doc = await _db
          .collection(
              'cuidadores/$uid/dependente/$idDependente/cuidadoresSecundarios')
          .doc(idCuidadorSecundario)
          .get();

      if (doc.exists) {
        return CuidadoresSecundarios.fromFirestore(doc);
      } else {
        throw Exception("Cuidador Secundario não encontrada");
      }
    } catch (e) {
      throw Exception("Erro ao obter cuidador secundario: $e");
    }
  }

  editarCuidadorSecundario(CuidadoresSecundarios cuidadoresSecundarios,
      String idCuidadoresSecundarios) async {
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
          .collection(
              'cuidadores/$uid/dependente/$idDependente/cuidadoresSecundarios')
          .doc(idCuidadoresSecundarios)
          .update({
        'nome': cuidadoresSecundarios.nome,
        'idade': cuidadoresSecundarios.idade,
        'parentescoFuncao': cuidadoresSecundarios.parentescoFuncao,
        'email': cuidadoresSecundarios.email,
        'telefone': cuidadoresSecundarios.telefone,
      });
      Get.snackbar(
        "Sucesso",
        "Cuidador Secundario editada com sucesso!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        "Erro",
        "Não foi possível editar a cuidador secundario: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }

  excluirCuidadorSecundario(String idCuidadoresSecundarios) async {
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
      throw Exception("Dependente não encontrado para o cuidador principal");
    }

    try {
      await _db
          .collection('cuidadores/$uid/dependente/$idDependente/cuidadoresSecundarios')
          .doc(idCuidadoresSecundarios)
          .delete();
      Get.snackbar(
        "Sucesso",
        "Cuidador excluída com sucesso!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        "Erro",
        "Não foi possível excluir o cuidador: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}
