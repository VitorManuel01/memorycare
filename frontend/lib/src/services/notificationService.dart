import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/tarefas_controller.dart';
import 'package:memorycare/src/models/tarefa.dart';
import 'package:memorycare/src/views/tarefas/Tarefas.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future<void> init() async {
    tz.initializeTimeZones();
    final location = tz.getLocation('America/Sao_Paulo');
    tz.setLocalLocation(location);

    const android = AndroidInitializationSettings(
        "alarme"); // Certifique-se de que o ícone existe
    const settings = InitializationSettings(android: android);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        // Trate a notificação aqui
        try {
          Get.to(() => const Tarefas()); // Exemplo de navegação
          onNotifications.add(response.payload);
        } catch (e, stackTrace) {
          print("Erro ao processar a notificação: $e");
          print(stackTrace);
        }
      },
    );
  }

  // Configurações de detalhes da notificação
  static Future<NotificationDetails> _notificationDetails() async {
    const android = AndroidNotificationDetails(
      'NotificaçõesMemoryCare', // ID do canal
      'NotificaçõesMemoryCare', // Nome do canal
      channelDescription: 'Descrição do canal',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    return NotificationDetails(android: android);
  }

  // Agendar notificações para cada tarefa
  static Future<void> scheduleNotifications() async {
    final tarefaController = Get.put(TarefasController());
    final user = FirebaseAuth.instance.currentUser;
    // Obter a lista de tarefas como um Stream
    
    if (user != null) {
      // O usuário está autenticado, pode realizar operações no Firestore
      final tarefasStream = tarefaController.listaDeTarefas();
      await for (final tarefas in tarefasStream) {
        for (final tarefa in tarefas) {
          print('Agendando notificação para: ${tarefa.titulo}');
          await _scheduleNotificationForTask(tarefa);
        }
      }
    } else {
      print('Usuário não autenticado. Operação cancelada.');
      return;
      
    }
    // Usar await for para processar cada emissão do Stream
  }

  // Agendar uma notificação específica para uma tarefa
  static Future<void> _scheduleNotificationForTask(Tarefa tarefa) async {
    final datetime =
        tarefa.diaEhorario.toDate(); // Converte o Timestamp para DateTime.
    print('Data e Hora da Notificação: $datetime');

    final now = tz.TZDateTime.now(tz.local);
    // Garantir que a data esteja no futuro
    if (datetime.isBefore(now)) {
      return; // Não agenda notificações para datas passadas
    }

    final details = await _notificationDetails();
    final tzDateTime = tz.TZDateTime.from(datetime, tz.local);
    DateTime dateTime = DateTime.now();
    print("Fuso: ${dateTime.timeZoneName}");
    print("Fuso: ${dateTime.timeZoneOffset}");
    print('Notificação agendada para: $tzDateTime');
    final localTimeZone = tz.local;
    print('Fuso horário local: ${localTimeZone.name}');

    await _notifications.zonedSchedule(
      tarefa.id.hashCode, // ID único baseado no hash do ID da tarefa
      tarefa.titulo, // Título da tarefa
      tarefa.descricao, // Descrição da tarefa
      tzDateTime,
      details,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }
}
