import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:memorycare/src/controllers/areas_controller.dart';
import 'package:memorycare/src/models/area.dart';
import 'package:memorycare/src/services/geofencingService.dart';
import 'package:memorycare/src/views/geolocalizacao/mapa.dart';
import 'package:memorycare/src/views/geolocalizacao/removerGeofence.dart';
import 'package:memorycare/src/widgets/ButaoDeTarefas.dart';

class AllGeoFences extends StatelessWidget {
  final TextEditingController raioController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();
  AllGeoFences({
    super.key,
  });
  final ConfigurarAreaController controller =
      Get.put(ConfigurarAreaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remover Área'),
      ),
      body: StreamBuilder<List<Area>>(
          stream: controller.listaDeAreas(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Sem Areas'));
            }

            final areas = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                // Permite a rolagem do conteúdo
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap:
                          true, // Evita que o ListView ocupe todo o espaço disponível
                      itemCount: areas.length,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        final area = areas[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: ButaoDeTarefas(
                            taskName: area.nome,
                            onPress: () {
                              TelaRemoverArea.buildShowModalBottomSheet(
                                  context, area.id!, area.nome);
                            },
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
