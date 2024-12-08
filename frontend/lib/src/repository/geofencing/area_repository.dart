import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/area.dart';

class AreaRepository extends GetxController {
  static AreaRepository get instance => Get.find();

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

  Future<void> salvarArea(Area area) async {
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

    await _db
        .collection('cuidadores/$uid/dependente/$idDependente/areas')
        .add(area.toJson());
  }


    Future<Stream<List<Area>>> getAreas() async {
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
        .collection('cuidadores/$uid/dependente/$idDependente/areas')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Area.fromFirestore(doc)).toList());

    return Future.value(stream);
  }

    excluirArea(String idArea) async {

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
          .collection('cuidadores/$uid/dependente/$idDependente/areas')
          .doc(idArea)
          .delete();
      Get.snackbar(
        "Sucesso",
        "Area excluída com sucesso!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        "Erro",
        "Não foi possível excluir a Area: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
  
}
