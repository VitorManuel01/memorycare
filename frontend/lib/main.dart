import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/firebase_options.dart';
import 'package:memorycare/src/app.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';

/// Função principal que inicia o aplicativo.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(
      const MemoryCareApp()); // `MemoryCareApp` é a classe raiz do aplicativo.
}
