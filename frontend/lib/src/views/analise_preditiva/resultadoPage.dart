import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';
import 'package:memorycare/src/views/home/HomePage.dart';

class ResultadoPage extends StatelessWidget {
  const ResultadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnalisePreditivaController>();
    return Scaffold(
      appBar: AppBar(title: const Text("Resultado")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pontuação: ${controller.pontuacaoTotal.value}"),
            Text("Resultado: ${controller.resultado}"),
            ElevatedButton(
              onPressed: () {
                controller.salvarResultados(controller.pontuacaoTotal.value,
                    controller.resultado.value);
                controller.resetar();
                Get.offAll(() => const HomePage());
              },
              child: const Text("Finalizar"),
            ),
          ],
        ),
      ),
    );
  }
}
