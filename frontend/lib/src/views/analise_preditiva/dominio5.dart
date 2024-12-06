import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';
import 'package:memorycare/src/views/analise_preditiva/dominio6.dart';
import 'package:memorycare/src/views/analise_preditiva/resultadoPage.dart';

class Dominio5 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

    final acertou = false.obs;

  Dominio5({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Memória"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pergunta 1
            Obx(() {
              return CheckboxListTile(
                title: const Text(
                    "Quais eram as três palavras que pedi para você lembrar anteriormente?"),
                value: acertou.value,
                onChanged: (bool? isChecked) {
                  acertou.value =
                      isChecked ?? false; // Marca a resposta corretamente
                },
              );
            }),

            const SizedBox(height: 20),
            const Text(
                "○ (Casa, Bola, Árvore)"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Conta os acertos (quantidade de checkboxes marcados)
                if (acertou.value) {
                  analisePreditivaController.adicionarPontos(3);
                }

                 Get.toNamed('/dominio6');
              },
              child: const Text("Próximo"),
            ),
          ],
        ),
      ),
    );
  }
}
