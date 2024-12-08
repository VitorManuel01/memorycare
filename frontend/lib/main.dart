import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/firebase_options.dart';
import 'package:memorycare/src/app.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';
import 'package:memorycare/src/services/AnalisePredNotificationService.dart';
import 'package:memorycare/src/services/geofencingService.dart';
import 'src/services/tarefasNotificationService.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Função principal que inicia o aplicativo.
Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  await initializeDateFormatting('pt_BR', null);
  await TarefasNotificationService.init();
  TarefasNotificationService.scheduleNotifications();
  await AnalisePredNotificationService.init();
  AnalisePredNotificationService.scheduleNotifications();
   GeofencingService geofencingService = GeofencingService();
  geofencingService.configureBackgroundGeolocation();

  runApp(
      const MemoryCareApp()); // `MemoryCareApp` é a classe raiz do aplicativo.
}
