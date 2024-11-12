import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/cuidadores.dart';

class CuidadorRepository extends GetxController {
  static CuidadorRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

createCuidador(Cuidadores cuidador) async {
  try {
    await _db
        .collection("cuidadores")
        .add(cuidador.toJson())
        .whenComplete(
          () => Get.snackbar("Sucesso", "A sua conta foi registrada",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),
        );
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
