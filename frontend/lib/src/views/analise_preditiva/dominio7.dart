import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';

class Dominio7 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

  final List<RxBool> respostas = List.generate(1, (_) => false.obs);

  Dominio7({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Habilidade Visuoespacial"),
      ),
      body: SingleChildScrollView(
        // Envolva o conteúdo com SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nomeação"),
            Obx(() {
              return CheckboxListTile(
                title: const Text(
                    "Mostre ao paciente uma figura de dois pentágonos que se interseccionam."),
                value: respostas[0].value,
                onChanged: (bool? isChecked) {
                  respostas[0].value = isChecked ?? false;
                },
              );
            }),
            const Text("Peça ao paciente para copiar o desenho."),
            // Botão para mostrar a imagem em forma de pop-up
            ElevatedButton(
              onPressed: () {
                _showPentagonsImageDialog(
                    context); // Mostra o pop-up com a imagem do relógio
              },
              child: const Text("Mostrar Imagem"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Conta os acertos (quantidade de checkboxes marcados)
                int acertos =
                    respostas.where((resposta) => resposta.value).length;

                // Chama o método para adicionar os pontos ao final

                  analisePreditivaController.adicionarPontos(acertos);
                

                analisePreditivaController.determinarResultado();
                Get.toNamed('/resultado');
              },
              child: const Text("Finalizar"),
            ),
          ],
        ),
      ),
    );
  }

  // Função para mostrar o pop-up com a imagem do relógio
  void _showPentagonsImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peça ao paciente para copiar o desenho.'),
          content: Image.asset(
              'assets/images/pentagonos.PNG'), // Substitua pelo caminho da sua imagem
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Fecha o pop-up
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
