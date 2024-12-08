import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';

class Dominio2 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

  // Controle das respostas (booleano, se acertou ou não)
  final List<RxBool> respostas =
      List.generate(5, (_) => false.obs);

  Dominio2({super.key}); // 5 perguntas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orientação Espacial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            Obx(() {
              return CheckboxListTile(
                title: const Text(
                    "Onde estamos agora (exemplo: casa, hospital, consultório)?"),
                value: respostas[0].value,
                onChanged: (bool? isChecked) {
                  respostas[0].value = isChecked ?? false;
                },
              );
            }),


            Obx(() {
              return CheckboxListTile(
                title: const Text("Em que cidade estamos?"),
                value: respostas[1].value,
                onChanged: (bool? isChecked) {
                  respostas[1].value = isChecked ?? false;
                },
              );
            }),


            Obx(() {
              return CheckboxListTile(
                title: const Text("Em que estado estamos?"),
                value: respostas[2].value,
                onChanged: (bool? isChecked) {
                  respostas[2].value = isChecked ?? false;
                },
              );
            }),


            Obx(() {
              return CheckboxListTile(
                title: const Text("Qual é o nome do local onde estamos agora?"),
                value: respostas[3].value,
                onChanged: (bool? isChecked) {
                  respostas[3].value = isChecked ?? false;
                },
              );
            }),


            Obx(() {
              return CheckboxListTile(
                title: const Text("Em que andar ou pavimento estamos?"),
                value: respostas[4].value,
                onChanged: (bool? isChecked) {
                  respostas[4].value = isChecked ?? false;
                },
              );
            }),

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
              child: const Text("Próximo"),
            ),
          ],
        ),
      ),
    );
  }
}
