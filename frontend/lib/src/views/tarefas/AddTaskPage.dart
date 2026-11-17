import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:memorycare/src/models/tarefa.dart';
import 'package:memorycare/src/views/tarefas/Tarefas.dart';

import '../../controllers/tarefas_controller.dart';
import '../../models/StatusTarefa.dart';

class DataHoraController2 extends GetxController {
  RxString tempo = "Selecionar horário".obs;
}

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DataHoraController2 dataHoraController = Get.put(DataHoraController2());
    final TarefasController registroTarefasController = Get.put(TarefasController());

    final TextEditingController tituloController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
    final Rx<StatusTarefa?> statusSelecionado = Rx<StatusTarefa?>(null);
    final Rx<bool> tarefaSeRepete = false.obs;
    Timestamp? diaEhorario;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Título da página
            const Center(
              child: Text(
                'Adicionar Nova Tarefa',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de título
            TextField(
              controller: tituloController,
              decoration: InputDecoration(
                labelText: 'Título da Tarefa',
                labelStyle: const TextStyle(color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Campo de descrição
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: const TextStyle(color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.green),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
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

                TimeOfDay? horaSelecionada = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (horaSelecionada != null) {
                  DateTime dateTime = DateTime(
                    dataSelecionada!.year,
                    dataSelecionada.month,
                    dataSelecionada.day,
                    horaSelecionada.hour,
                    horaSelecionada.minute,
                  );

                  // Converte para Timestamp
                  diaEhorario = Timestamp.fromDate(dateTime);

                  // Atualiza a variável reativa com o horário selecionado
                  dataHoraController.tempo.value =
                      "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} - ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
                }
              },
              color: Colors.greenAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                children: [
                  const Icon(
                    LineAwesomeIcons.clock,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Obx(() => Text(
                    dataHoraController.tempo.value,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  )),
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
                  activeColor: Colors.green,
                )),
                const Text('Repetir tarefa', style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),

            // Botão para salvar a tarefa
            ElevatedButton(
              onPressed: () {
                if (tituloController.text.isNotEmpty && diaEhorario != null) {
                  // Criação da tarefa
                  Tarefa tarefa = Tarefa(
                    titulo: tituloController.text,
                    descricao: descricaoController.text,
                    diaEhorario: diaEhorario!,
                    status: StatusTarefa.pendente,
                    tarefaSeRepete: tarefaSeRepete.value,
                    criadoEm: Timestamp.now(),
                  );

                  // Envia a tarefa para o controller salvar
                  registroTarefasController.createTarefa(tarefa);

                  // Navega para a página de tarefas
                  Get.to(() => const Tarefas());
                } else {
                  Get.snackbar("Erro", "Preencha todos os campos corretamente", backgroundColor: Colors.red, colorText: Colors.white);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Salvar Tarefa',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
