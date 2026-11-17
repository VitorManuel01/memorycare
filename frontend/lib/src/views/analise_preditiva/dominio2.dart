import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';

class Dominio2 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

  // Controle das respostas (booleano, se acertou ou não)
  final List<RxBool> respostas = List.generate(5, (_) => false.obs);

  Dominio2({super.key}); // 5 perguntas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orientação Espacial"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Responda as perguntas abaixo:",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ..._buildCheckboxes(context),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Conta os acertos (quantidade de checkboxes marcados)
                int acertos =
                    respostas.where((resposta) => resposta.value).length;

                // Chama o método para adicionar os pontos ao final
                analisePreditivaController.adicionarPontos(acertos);

                Get.toNamed('/dominio3');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Próximo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCheckboxes(BuildContext context) {
    final perguntas = [
      "Onde estamos agora (exemplo: casa, hospital, consultório)?",
      "Em que cidade estamos?",
      "Em que estado estamos?",
      "Qual é o nome do local onde estamos agora?",
      "Em que andar ou pavimento estamos?"
    ];

    return List<Widget>.generate(
      perguntas.length,
      (index) => Obx(
        () => Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: CheckboxListTile(
            title: Text(
              perguntas[index],
              style: Theme.of(context).textTheme.titleMedium
            ),
            activeColor: Colors.teal,
            value: respostas[index].value,
            onChanged: (bool? isChecked) {
              respostas[index].value = isChecked ?? false;
            },
          ),
        ),
      ),
    );
  }
}
