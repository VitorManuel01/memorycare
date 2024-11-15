import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/cuidadores.dart';
import 'package:memorycare/src/views/registro/RegistroDependente.dart';

class CuidadorRepository extends GetxController {
  static CuidadorRepository get instance => Get.find();

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

  // Função para criar um cuidador
  createCuidador(Cuidadores cuidador) async {
    try {
      // Obtém o UID do usuário autenticado antes de prosseguir
      String? uid = await obterUidUsuario();

      // Verifica se o UID foi obtido corretamente
      if (uid != null) {
        // Cria o documento no Firestore com o UID como ID
        await _db
            .collection("cuidadores")
            .doc(uid) // Usa o UID do usuário como o ID do documento
            .set(cuidador.toJson())
            .whenComplete(() => Get.snackbar(
                  "Sucesso",
                  "A sua conta foi registrada",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green.withOpacity(0.1),
                  colorText: Colors.green,
                ));
        Get.to(() => const RegistroDependente());
      } else {
        Get.snackbar("Erro", "Usuário não autenticado.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.1),
            colorText: Colors.red);
      }
    } catch (error, stackTrace) {
      print("Error: $error");
      print("StackTrace: $stackTrace");
      Get.snackbar("Erro", "Erro ao registrar, por favor tente novamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red);
    }
  }

  Future<Cuidadores> getCuidador(String uid) async {
    String? uid = await obterUidUsuario();

    try {
      DocumentSnapshot doc = await _db.collection('cuidadores').doc(uid).get();

      if (doc.exists) {
        return Cuidadores.fromFirestore(doc);
      } else {
        throw Exception("Cuidador não encontrado");
      }
    } catch (e) {
      throw Exception("Erro ao obter cuidador: $e");
    }
  }

Future<bool> hasCuidador() async {
  try {
    String? uid = await obterUidUsuario(); // Obtém o UID do usuário atual
    if (uid == null) {
      print("UID é nulo.");
      return false;
    }

    // Verifica se existe um cuidador com o mesmo ID do usuário
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _db.collection('cuidadores').doc(uid).get();

    if (doc.exists) {
      print("Cuidador encontrado: ${doc.id}");
      return true; // Retorna true se o cuidador com o mesmo UID for encontrado
    } else {
      print("Cuidador não encontrado.");
      return false; // Retorna false se o cuidador não for encontrado
    }
  } catch (e) {
    print("Erro ao verificar cuidador: $e");
    return false; // Retorna false em caso de erro
  }
}
}
