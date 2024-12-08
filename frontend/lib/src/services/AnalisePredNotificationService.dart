import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/repository/analise_preditiva/analise_preditiva_repository.dart';
import 'package:memorycare/src/views/analise_preditiva/dominio1.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class AnalisePredNotificationService {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static final analisePredRepo = Get.put(AnalisePreditivaRepository());

  static int gerarIdUnico() {
    return DateTime.now().millisecondsSinceEpoch.remainder(100000);
  }

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
          Get.to(() => Dominio1()); // Exemplo de navegação
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
      'Analises_Preditivas_notification', // ID do canal
      'Teste_Cognitivo', // Nome do canal
      channelDescription: 'Notificações de Testes Cognitivos',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    return const NotificationDetails(android: android);
  }

  // Agendar notificações para cada tarefa
  static Future<void> scheduleNotifications() async {
    final user = FirebaseAuth.instance.currentUser;
    // Obter a lista de tarefas como um Stream

    if (user != null) {
      // O usuário está autenticado, pode realizar operações no Firestore
      await _scheduleNotificationForAnalise();
    } else {
      print('Usuário não autenticado. Operação cancelada.');
      return;
    }
    // Usar await for para processar cada emissão do Stream
  }

  // Agendar uma notificação específica para uma tarefa
  static Future<void> _scheduleNotificationForAnalise() async {
    var id1 = gerarIdUnico();
    var id2 = gerarIdUnico();

    bool statusTeste = await analisePredRepo.verificarStatusTeste();
    bool existeTeste = await analisePredRepo.verificarDocumentoExistente();

    if (statusTeste) {
      print("existe um teste cognitivo feito");
    }

    final details = await _notificationDetails();
// Verifica se o teste ainda não foi feito ou se o documento não existe
    if (!existeTeste) {
      print(
          'A notificação da Análise Preditiva da semana vai aparecer imediatamente');
      await _notifications.show(
        id1,
        'Teste de Análise Preditiva',
        'Não se esqueça de realizar o teste de análise preditiva.',
        details,
      );
    }
// Se o teste não foi feito e o dia não for segunda-feira, agenda uma notificação
    else if (!statusTeste) {
      print('Agendando notificação da Análise Preditiva da semana');
      DateTime proximoDia = DateTime.now().add(const Duration(days: 1));
      final tzDateTime = tz.TZDateTime.from(proximoDia, tz.local);
      print('Notificação do teste cognitivo agendada para: $tzDateTime');
      final localTimeZone = tz.local;
      print('Fuso horário local: ${localTimeZone.name}');

      // Enviar a notificação novamente amanhã, até que o teste seja feito
      await _notifications.zonedSchedule(
        id2,
        'Teste de Análise Preditiva',
        'Não se esqueça de realizar o teste de análise preditiva.',
        tzDateTime,
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

}
