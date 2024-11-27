import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memorycare/src/controllers/cuidadores_secundarios_controller.dart';
import 'package:memorycare/src/models/cuidadoresSucundarios.dart';
import 'package:memorycare/src/views/perfil/EditarPerfilCuidadorSecundario.dart';
import 'package:memorycare/src/views/registro/AddCuidadorSecundarioPage.dart';
import '../../widgets/ButaoDeTarefas.dart';

class PerfilCuidadorSecundario extends StatelessWidget {
  const PerfilCuidadorSecundario({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    final controller = Get.put(CuidadoresSecundariosController());

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0XFF272727) : const Color(0xFFB7D3A8),
      appBar: AppBar(
        title: const Text('Cuidadores Secundários'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Funcionalidade futura
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 32,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "CONVIDAR",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.add_circle,
                    color: Colors.green,
                    size: 80,
                  ),
                  onPressed: () {
                    Get.to(() => const AddCuidadorSecundarioPage());
                  },
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromARGB(255, 66, 66, 66)
                        : const Color(0xFF507D5A),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(40)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Cuidadores',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: StreamBuilder<List<CuidadoresSecundarios>>(
                            stream: controller.listaDeCuidSec(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Erro: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('Sem Cuidadores Secundários'));
                              }

                              final cuidadoresSecundarios = snapshot.data!;
                              return ListView.builder(
                                itemCount: cuidadoresSecundarios.length,
                                padding: const EdgeInsets.only(bottom: 20),
                                itemBuilder: (context, index) {
                                  final cuidadorSecundario =
                                      cuidadoresSecundarios[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: ButaoDeTarefas(
                                      taskName: cuidadorSecundario.nome,
                                      onPress: () {
                                        Get.to(() =>
                                            EditarPerfilCuidadorSecundario(
                                                idCuidSec:
                                                    cuidadorSecundario.id!));
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
