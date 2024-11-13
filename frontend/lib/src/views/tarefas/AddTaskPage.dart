import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:memorycare/src/models/tarefa.dart';
import 'package:memorycare/src/views/tarefas/Tarefas.dart';

import '../../controllers/tarefas_controller.dart';
import '../../models/StatusTarefa.dart';

class DataHoraController extends GetxController {
  // Variável reativa para armazenar a data e hora como string
  RxString tempo = "Selecionar horário".obs;
}
/// Página para adicionar novas tarefas.
class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Criação da instância do controller
    final DataHoraController dataHoraController = Get.put(DataHoraController());
    final TarefasController registroTarefasController = Get.put(TarefasController());

    // Variáveis locais para os dados da tarefa
    final TextEditingController tituloController = TextEditingController();
    final Rx<StatusTarefa?> statusSelecionado = Rx<StatusTarefa?>(null);
    final Rx<bool> tarefaSeRepete = false.obs;
    Timestamp? diaEhorario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Texto de título
            const Center(
              child: Text(
                'Página para adicionar novas tarefas',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 16),

            // Campo para o título da tarefa
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(labelText: 'Título da Tarefa'),
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

            // Botão para salvar a tarefa
            ElevatedButton(
              onPressed: () {
                if (tituloController.text.isNotEmpty && diaEhorario != null) {
                  // Criação da tarefa
                  Tarefa tarefa = Tarefa(
                  //  idDependente: 'id_dependente', // Substitua pelo ID real do dependente
                    titulo: tituloController.text,
                    diaEhorario: diaEhorario!,
                    status: StatusTarefa.pendente, // Ajuste conforme necessário
                    tarefaSeRepete: tarefaSeRepete.value,
                    criadoEm: Timestamp.now(),
                  );

                  // Envia a tarefa para o controller salvar
                  registroTarefasController.createTarefa(tarefa);

                  // Exibe uma mensagem de sucesso
                  Get.snackbar("Sucesso", "Tarefa criada com sucesso");

                  // Navega para a página inicial ou outra página desejada
                  Get.to(() => const Tarefas());
                } else {
                  Get.snackbar("Erro", "Preencha todos os campos corretamente");
                }
              },
              child: const Text('Salvar Tarefa'),
            ),
          ],
        ),
      ),
    );
  }
}

