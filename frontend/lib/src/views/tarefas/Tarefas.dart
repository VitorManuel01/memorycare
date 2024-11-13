import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/tarefas_controller.dart';
import 'package:memorycare/src/views/tarefas/AddTaskPage.dart';

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

    // Instância do repositório para pegar as tarefas
    final controller = Get.put(TarefasController());

    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0XFF272727) : const Color(0xFFB7D3A8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Segunda-Feira',
                    style: TextStyle(fontSize: 20, color: Colors.black87),
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
              const Text('00:00',
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 10),
              const Text('Convidar',
                  style: TextStyle(fontSize: 18, color: Colors.white)),
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
                          child: StreamBuilder<Stream<List<Tarefa>>>(
                            stream: controller
                                .listaDeTarefas(), // Aqui estamos usando o Stream<Stream<List<Tarefa>>>
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Erro: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data == null) {
                                return const Center(child: Text('Sem tarefas'));
                              }

                              // Agora, obtemos o stream de tarefas (Stream<List<Tarefa>>)
                              final streamTarefas = snapshot.data!;

                              return StreamBuilder<List<Tarefa>>(
                                stream:
                                    streamTarefas, // Passa o Stream<List<Tarefa>> do stream de tarefas
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
                                        child: Text('Sem tarefas'));
                                  }

                                  final tarefas = snapshot.data!;
                                  return ListView.builder(
                                    itemCount: tarefas.length,
                                    itemBuilder: (context, index) {
                                      final tarefa = tarefas[index];
                                      return ButaoDeTarefas(
                                        taskName: tarefa.titulo,
                                        onPress: () {
                                          
                                          // Get.to(() =>
                                          //     TaskPage(tarefaId: tarefa.id));
                                        },
                                      );
                                    },
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
