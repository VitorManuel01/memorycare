import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';

class Dominio1 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

  // Controle das respostas (booleano, se acertou ou não)
  final List<RxBool> respostas = List.generate(5, (_) => false.obs);

  Dominio1({super.key}); // 5 perguntas

  @override
  Widget build(BuildContext context) {
    var mediaQuerry = MediaQuery.of(context);

    var brightness = mediaQuerry.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final backgroundColor =
        isDarkMode ? const Color(0XFF272727) : Colors.greenAccent;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orientação Temporal"),
        centerTitle: true,
        backgroundColor: backgroundColor,
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

                Get.toNamed('/dominio2');
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
      "Qual é o ano atual?",
      "Qual é o mês atual?",
      "Qual é o dia da semana?",
      "Qual é o dia do mês?",
      "Qual é a estação do ano?"
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
              style: Theme.of(context).textTheme.titleMedium,
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
