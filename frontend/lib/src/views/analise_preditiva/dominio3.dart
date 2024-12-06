import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';
import 'package:memorycare/src/views/analise_preditiva/dominio2.dart';
import 'package:memorycare/src/views/analise_preditiva/dominio4.dart';
import 'package:memorycare/src/views/analise_preditiva/resultadoPage.dart';

class Dominio3 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

  final acertou = false.obs;

  Dominio3({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Palavras"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Pergunta 1
            Obx(() {
              return CheckboxListTile(
                title: const Text("Vou dizer três palavras. Por favor, repita-as depois de mim: 'casa, bola, árvore'."),
                value: acertou.value,
                onChanged: (bool? isChecked) {
                  acertou.value = isChecked ?? false; // Marca a resposta corretamente
                },
              );
            }),



            const SizedBox(height: 20),
           const Text("Repita as palavras até que o idoso consiga repetir corretamente(máximo de 6 tentativas)."),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Conta os acertos (quantidade de checkboxes marcados)
                if(acertou.value){
                  analisePreditivaController.adicionarPontos(3);  
                }

                Get.toNamed('/dominio4');
              },
              child: const Text("Próximo"),
            ),
          ],
        ),
      ),
    );
  }
}
