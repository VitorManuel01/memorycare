import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memorycare/src/controllers/tarefas_controller.dart';
import 'package:memorycare/src/views/tarefas/AddTaskPage.dart';
import 'package:memorycare/src/views/tarefas/editOrRemoveTaskPage.dart';

import '../../models/tarefa.dart';
import '../../widgets/ButaoDeTarefas.dart';

class Tarefas extends StatelessWidget {
  const Tarefas({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    RxString horario =
        RxString("${TimeOfDay.now().hour}:${TimeOfDay.now().minute}");

    void atualizarHora() {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        horario.value = "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}";
      });
    }

    // Inicia a atualização do horário assim que o widget for carregado
    atualizarHora();

    // Instância do repositório para pegar as tarefas
    final controller = Get.put(TarefasController());

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0XFF272727) : const Color(0xFFB7D3A8),
      appBar: AppBar(
        title: const Text('Tarefas'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('EEEE', 'pt_BR')
                        .format(DateTime.now())
                        .toUpperCase(),
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.green, size: 30),
                    onPressed: () {
                      Get.to(() => const AddTaskPage());
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() => Text(
                    horario.value,
                    style: Theme.of(context).textTheme.displayLarge,
                  )),
              const SizedBox(height: 10),
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
                        const Text('Tarefas',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(height: 20),

                        // Usando o StreamBuilder para exibir as tarefas
                        Expanded(
                          child: StreamBuilder<List<Tarefa>>(
                            stream: controller
                                .listaDeTarefas(), // Passa o Stream<List<Tarefa>> do stream de tarefas
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
                                return const Center(child: Text('Sem tarefas'));
                              }

                              final tarefas = snapshot.data!;
                              return ListView.builder(
                                itemCount: tarefas.length,
                                padding: const EdgeInsets.only(
                                    bottom: 20),
                                itemBuilder: (context, index) {
                                  final tarefa = tarefas[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5), 
                                    child: ButaoDeTarefas(
                                      taskName: tarefa.titulo,
                                      onPress: () {
                                        Get.to(() => EditorRemoveTaskPage(
                                            tarefaId: tarefa.id!));
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
