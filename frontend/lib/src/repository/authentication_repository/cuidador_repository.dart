import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
}
