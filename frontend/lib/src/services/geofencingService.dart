import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:memorycare/src/controllers/areas_controller.dart';
import 'package:memorycare/src/models/area.dart';
import 'package:memorycare/src/services/geofenceNotificationService.dart';

class GeofencingService {
  GeofenceNotificationService notificationService =
      GeofenceNotificationService();

  void configureBackgroundGeolocation() {
    bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) {
      if (event.action == 'ENTER') {
        print("Entrou na área: ${event.identifier}");
        notificationService.mostrarNotificacao(
            "Entrou na área", event.identifier);
      } else if (event.action == 'EXIT') {
        print("Saiu da área: ${event.identifier}");
        notificationService.mostrarNotificacao(
            "Saiu na área", event.identifier);
      }
    });

    // Inicialize o plugin
    bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 10.0,
      stopOnTerminate: false,
      startOnBoot: true,
      geofenceProximityRadius:
          1000, // Distância máxima para detectar áreas geográficas
      debug: true, // Para desenvolvimento, mostra notificações de depuração
      logLevel: bg.Config.LOG_LEVEL_VERBOSE, // Verbo para depuração
    )).then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start(); // Inicia o serviço de localização
      }
    });
  }

  void configurarGeofence(Area area) {
    bg.BackgroundGeolocation.addGeofence(bg.Geofence(
      identifier: area.nome, // Nome da área como identificador
      latitude: area.centro.latitude,
      longitude: area.centro.longitude,
      radius: area.raio, // Raio da área
      notifyOnEntry: true, // Notifica ao entrar
      notifyOnExit: true, // Notifica ao sair
      loiteringDelay:
          5000, // (Opcional) Tempo em ms para acionar evento de entrada
    ));
    print("Adicionando Area para Geofence");
  }

  void sincronizarGeofences(Area area) async {
    List<Geofence> ativos = await BackgroundGeolocation.geofences;
    var areas = <Area>[];
    areas.add(area);
    List<Area> areasFirebase = areas;

    for (var area in areasFirebase) {
      if (!ativos.any((geo) => geo.identifier == area.nome)) {
        BackgroundGeolocation.addGeofence(Geofence(
          identifier: area.nome,
          radius: area.raio,
          latitude: area.centro.latitude,
          longitude: area.centro.longitude,
          notifyOnEntry: true,
          notifyOnExit: true,
        ));
      }
    }
    BackgroundGeolocation.geofences.then((List<Geofence> geofences) {
      print("Geofences ativos: $geofences");
    });
  }

  void removerGeofence(String identifier) {
    bg.BackgroundGeolocation.removeGeofence(identifier).then((_) {
      print('Geofence $identifier removido com sucesso.');
    }).catchError((error) {
      print('Erro ao remover geofence: $error');
    });
  }
}
