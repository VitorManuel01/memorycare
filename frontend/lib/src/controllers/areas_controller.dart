import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:memorycare/src/models/area.dart';
import 'package:memorycare/src/repository/geofencing/area_repository.dart';
import 'package:memorycare/src/services/geofencingService.dart';
import 'package:rxdart/transformers.dart';

class ConfigurarAreaController extends GetxController {
  @override
  void onInit() {
    super.onInit();

    obterLocalizacaoAtual(); // Obtém a localização quando o controlador é iniciado a cada segundo
  }

  var centro = Rx<LatLng?>(null); // Inicialmente nulo // Centro do mapa inicial
  // var raio = 500.0.obs; // Raio da área em metros
  final areaRepo = Get.put(AreaRepository());
  var areas = <Area>[].obs;
  // var nome = "".obs;
  GeofencingService geofencingService = GeofencingService();
  final MapController mapController = MapController();

  salvarArea(Area area) async {
    await areaRepo.salvarArea(area);
    geofencingService.configurarGeofence(area);
  }

  Future<Stream<List<Area>>> listaDeAreasFuture() {
    return areaRepo.getAreas();
  }

  Stream<List<Area>> listaDeAreas() {
    return listaDeAreasFuture().asStream().flatMap((stream) => stream);
  }

  // void obterAreasDoFirebase(List<Area> areasF) async {
  //   for (var area in areasF) {
  //     var nome = area.nome;
  //     areas.add(area);
  //     print("Area adicionada $nome");
  //   }
  // }

  // Future<void> carregarAreas() async {
  //   try {
  //     final areasList =
  //         await streamToList(); // Resolva o Future ou consuma a Stream
  //     areas.addAll(areasList);
  //     print("Areas Salvas: $areasList"); // Adiciona as áreas à lista observável
  //   } catch (e) {
  //     print('Erro ao carregar áreas: $e');
  //   }
  // }
  // void atualizarMapa() {
  //   if (centro.value != null) {
  //     mapController.move(centro.value!, 13);
  //   }
  // }

  // Método para obter a localização atual do dispositivo
  Future<void> obterLocalizacaoAtual() async {
    // Verifique se a permissão para acessar a localização foi concedida
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Solicitar ao usuário que habilite o serviço de localização
      return;
    }

    // Verifica a permissão para acessar a localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return; // A permissão foi negada, não pode acessar a localização
      }
    }

    // Obtenha a posição atual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Atualize o centro com a nova localização
    centro.value = LatLng(position.latitude, position.longitude);
  }

  excluirArea(String idArea, String identifier) {
    areaRepo.excluirArea(idArea);
    geofencingService.removerGeofence(identifier);
  }
}
