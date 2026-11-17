import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';

class Dominio3 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

  final acertou = false.obs;

  Dominio3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Palavras"),
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
              "Atividade de Memória:",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                child: Column(
                  children: [
                    Obx(
                      () => CheckboxListTile(
                        title: const Text(
                          "Vou dizer três palavras. Por favor, repita-as depois de mim: 'casa, bola, árvore'.",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        value: acertou.value,
                        activeColor: Colors.teal,
                        onChanged: (bool? isChecked) {
                          acertou.value = isChecked ?? false;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Repita as palavras até que o idoso consiga repetir corretamente (máximo de 6 tentativas).",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (acertou.value) {
                  analisePreditivaController.adicionarPontos(3);
                }
                Get.toNamed('/dominio4');
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
}
