import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';
import 'package:memorycare/src/views/analise_preditiva/dominio2.dart';
import 'package:memorycare/src/views/analise_preditiva/dominio5.dart';
import 'package:memorycare/src/views/analise_preditiva/resultadoPage.dart';

class Dominio4 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

    final acertou1 = false.obs;
   final acertou2 = false.obs;

  Dominio4({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Atenção e Cálculo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pergunta 1
            Obx(() {
              return CheckboxListTile(
                title: const Text(
                    "Vou dizer três palavras. Por favor, repita-as depois de mim: 'casa, bola, árvore'."),
                value: acertou1.value,
                onChanged: (bool? isChecked) {
                  acertou1.value =
                      isChecked ?? false; // Marca a resposta corretamente
                },
              );
            }),
            const SizedBox(height: 20),
            const Text(
                "Alternativa caso o paciente não consiga realizar subtrações:"),
            const SizedBox(height: 20),            
            Obx(() {
              return CheckboxListTile(
                title: const Text("Soletre a palavra 'MUNDO' ao contrário (ODNUM)."),
                value: acertou2.value,
                onChanged: (bool? isChecked) {
                  acertou2.value =
                      isChecked ?? false; // Marca a resposta corretamente
                },
              );
            }),

            const SizedBox(height: 20),
            const Text(
                "Repita as palavras até que o idoso consiga repetir corretamente(máximo de 6 tentativas)."),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Conta os acertos (quantidade de checkboxes marcados)
                if (acertou1.value || acertou2.value) {
                  analisePreditivaController.adicionarPontos(5);
                }

                Get.toNamed('/dominio5');

              },
              child: const Text("Próximo"),
            ),
          ],
        ),
      ),
    );
  }
}
