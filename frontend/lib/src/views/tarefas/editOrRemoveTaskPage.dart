import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:memorycare/src/views/tarefas/Tarefas.dart';

import '../../controllers/tarefas_controller.dart';
import '../../models/StatusTarefa.dart';
import '../../models/tarefa.dart';

class DataHoraController extends GetxController {
  RxString tempo = "Selecionar horário".obs;
}

class EditorRemoveTaskPage extends StatelessWidget {
  final String tarefaId;
  final DataHoraController dataHoraController = Get.put(DataHoraController());
  final TarefasController registroTarefasController =
      Get.put(TarefasController());

  EditorRemoveTaskPage({super.key, required this.tarefaId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tarefa>(
      future: registroTarefasController.getTarefa(tarefaId),
      builder: (BuildContext context, AsyncSnapshot<Tarefa> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text("Erro ao carregar tarefa: ${snapshot.error}"));
        } else if (!snapshot.hasData) {
          return const Center(child: Text("Tarefa não encontrada"));
        } else {
          // Dados da tarefa carregados com sucesso
          Tarefa tarefaEscolhida = snapshot.data!;

          // Variáveis locais para os dados da tarefa
          final TextEditingController tituloController =
              TextEditingController(text: tarefaEscolhida.titulo);
          final TextEditingController descricaoController =
              TextEditingController(text: tarefaEscolhida.descricao);
          StatusTarefa statusSelecionado = tarefaEscolhida.status;
          Rx<bool> tarefaSeRepete = Rx<bool>(tarefaEscolhida.tarefaSeRepete);

          Timestamp? diaEhorario = tarefaEscolhida.diaEhorario;

          // Atualiza a variável reativa fora do ciclo de construção
          WidgetsBinding.instance.addPostFrameCallback((_) {
            dataHoraController.tempo.value =
                tarefaEscolhida.diaEhorario.toDate().toString();
          });

          final Rx<bool> tarefaConcluida =
              Rx<bool>(tarefaEscolhida.status == StatusTarefa.concluida);

          return Scaffold(
            appBar: AppBar(
              title: const Text('Tarefa'),
              backgroundColor: Colors.green,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Texto de título
                  const SizedBox(height: 20),

                  // Campo para o título da tarefa
                  TextField(
                    controller: tituloController,
                    decoration:
                        const InputDecoration(labelText: 'Título da Tarefa'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descricaoController,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    maxLines: 7,
                  ),
                  const SizedBox(height: 16),

                  // Botão para selecionar data e hora
                  MaterialButton(
                    onPressed: () async {
                      DateTime? dataSelecionada = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (dataSelecionada != null) {
                        TimeOfDay? horaSelecionada = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (horaSelecionada != null) {
                          DateTime dateTime = DateTime(
                            dataSelecionada.year,
                            dataSelecionada.month,
                            dataSelecionada.day,
                            horaSelecionada.hour,
                            horaSelecionada.minute,
                          );

                          // Converte para Timestamp
                          diaEhorario = Timestamp.fromDate(dateTime);

                          // Atualiza a variável reativa com o horário selecionado
                          dataHoraController.tempo.value =
                              "${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute}";
                        }
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          LineAwesomeIcons.clock,
                          color: Colors.greenAccent,
                          size: 40,
                        ),
                        const SizedBox(width: 10),
                        Obx(() => Text(dataHoraController.tempo.value)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Checkbox para repetir a tarefa
                  Row(
                    children: [
                      Obx(() => Checkbox(
                            value: tarefaSeRepete.value,
                            onChanged: (value) {
                              tarefaSeRepete.value = value!;
                            },
                          )),
                      const Text('Repetir tarefa'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Checkbox para marcar a tarefa como concluída
                  Row(
                    children: [
                      Obx(() => Checkbox(
                            value: tarefaConcluida.value,
                            onChanged: (value) {
                              tarefaConcluida.value = value!;

                              if (value == true) {
                                statusSelecionado = StatusTarefa.concluida;
                              } else {
                                statusSelecionado = StatusTarefa.pendente;
                              }
                            },
                          )),
                      const Text('Marcar como concluída'),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Botão para Editar a tarefa
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            if (tituloController.text.isNotEmpty &&
                                diaEhorario != null) {
                              // Criação da tarefa
                              Tarefa tarefa = Tarefa(
                                titulo: tituloController.text,
                                descricao: descricaoController.text,
                                diaEhorario: diaEhorario!,
                                status: statusSelecionado,
                                tarefaSeRepete: tarefaSeRepete.value,
                                criadoEm: Timestamp.now(),
                              );

                              // Envia a tarefa para o controller salvar
                              registroTarefasController.editarTarefa(
                                  tarefa, tarefaId);

                              // Exibe uma mensagem de sucesso

                              // Navega para a página inicial ou outra página desejada
                              Get.to(() => const Tarefas());
                            } else {
                              Get.snackbar("Erro",
                                  "Preencha todos os campos corretamente");
                            }
                          },
                          child: const Text('SALVAR'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 160,
                        child: ElevatedButton(
                          onPressed: () {
                            registroTarefasController.excluirTarefa(tarefaId);
                            Get.snackbar(
                                "Sucesso", "Tarefa excluída com sucesso");
                            Get.to(() => const Tarefas());
                          },
                          child: const Text('EXCLUIR'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
