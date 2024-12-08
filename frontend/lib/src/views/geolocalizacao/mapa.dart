import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:memorycare/src/controllers/areas_controller.dart';
import 'package:memorycare/src/models/area.dart';
import 'package:memorycare/src/services/geofencingService.dart';
import 'package:memorycare/src/views/geolocalizacao/addGeofence.dart';
import 'package:memorycare/src/views/geolocalizacao/allGeofences.dart';
import 'package:memorycare/src/views/home/HomePage.dart';

class Mapa extends StatelessWidget {
  const Mapa({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuerry = MediaQuery.of(context);

    var brightness = mediaQuerry.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final ConfigurarAreaController controller =
        Get.put(ConfigurarAreaController());
    GeofencingService geofencingService = GeofencingService();
    return StreamBuilder<List<Area>>(
        stream: controller.listaDeAreas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } 

          final areas = snapshot.data;
          for (var area in areas!) {
            var nome = area.nome;
            print("Areas no snapshot: $nome");
            geofencingService.sincronizarGeofences(area);
          }

          // controller.obterAreasDoFirebase(areas);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Configurar Área de Geofencing'),
              actions: [
                IconButton(onPressed: ()=> (Get.offAll(()=> const HomePage())), icon: const Icon(Icons.arrow_back))
                
              ],
            ),
            body: Obx(() {
              if (controller.centro.value == null) {
                // Se ainda não obteve a localização, você pode exibir um carregando ou algo do tipo
                return const Center(child: CircularProgressIndicator());
              } else {
                return FlutterMap(
                  mapController: controller.mapController,
                  options: MapOptions(
                      initialCenter:
                          controller.centro.value!, // Usando o valor observável
                      initialZoom: 13,
                      onLongPress: (TapPosition position, LatLng latLng) {
                        // Ao pressionar longamente, abre a tela para escolher o raio
                        Get.to(() => AddGeoFence(localizacao: latLng));
                      },
                      onMapReady: () {
                        Timer.periodic(const Duration(seconds: 10), (timer) {
                          controller
                              .obterLocalizacaoAtual(); // Obtém a localização quando o controlador é iniciado a cada segundo
                          controller.mapController
                              .move(controller.centro.value as LatLng, 13);
                        });
                      }),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: controller.centro.value!,
                          child: const Icon(
                            Icons.circle,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    CircleLayer(
                      circles: areas!.map((area) {
                        return CircleMarker(
                          point: LatLng(
                              area.centro.latitude, area.centro.longitude),
                          useRadiusInMeter: true,
                          radius: area.raio, // Raio em metros
                          color: Colors.blue.withOpacity(0.3),
                          borderColor: Colors.blue,
                          borderStrokeWidth: 2,
                        );
                      }).toList(),
                    ),
                  ],
                );
              }
            }),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                print("click");
                Get.to(() => AllGeoFences());
              },
              child: const Icon(Icons.pin_drop_sharp),
            ),
          );
        });
  }
}
