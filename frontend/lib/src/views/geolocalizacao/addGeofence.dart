import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:memorycare/src/controllers/areas_controller.dart';
import 'package:memorycare/src/models/area.dart';
import 'package:memorycare/src/services/geofencingService.dart';
import 'package:memorycare/src/views/geolocalizacao/mapa.dart';

class AddGeoFence extends StatelessWidget {
  final LatLng localizacao;
  final TextEditingController raioController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  AddGeoFence({super.key, required this.localizacao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Geofence'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Digite o nome:'),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),
            const Text('Digite o raio em metros:'),
            TextField(
              controller: raioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Raio',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final double raio =
                    double.tryParse(raioController.text) ?? 500.0;

                Area area = Area(
                  nome: nomeController.value.text,
                  centro: GeoPoint(localizacao.latitude, localizacao.longitude),
                  raio: raio,
                );

                Get.find<ConfigurarAreaController>().salvarArea(area);
                Get.offAll(() => const Mapa());
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
