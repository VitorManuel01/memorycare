import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';
import 'package:memorycare/src/views/analise_preditiva/dominio2.dart';

class Dominio1 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

  // Controle das respostas (booleano, se acertou ou não)
  final List<RxBool> respostas =
      List.generate(5, (_) => false.obs); // 5 perguntas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orientação Temporal"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            Obx(() {
              return CheckboxListTile(
                title: const Text("Qual é o ano atual?"),
                value: respostas[0].value,
                onChanged: (bool? isChecked) {
                  respostas[0].value = isChecked ?? false;
                },
              );
            }),

            
            Obx(() {
              return CheckboxListTile(
                title: const Text("Qual é o mês atual?"),
                value: respostas[1].value,
                onChanged: (bool? isChecked) {
                  respostas[1].value = isChecked ?? false;
                },
              );
            }),

            
            Obx(() {
              return CheckboxListTile(
                title: const Text("Qual é o dia da semana?"),
                value: respostas[2].value,
                onChanged: (bool? isChecked) {
                  respostas[2].value = isChecked ?? false;
                },
              );
            }),

            
            Obx(() {
              return CheckboxListTile(
                title: const Text("Qual é o dia do mês?"),
                value: respostas[3].value,
                onChanged: (bool? isChecked) {
                  respostas[3].value = isChecked ?? false;
                },
              );
            }),

            
            Obx(() {
              return CheckboxListTile(
                title: const Text("Qual é a estação do ano?"),
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

                Get.toNamed('/dominio2');
              },
              child: const Text("Próximo"),
            ),
          ],
        ),
      ),
    );
  }
}
