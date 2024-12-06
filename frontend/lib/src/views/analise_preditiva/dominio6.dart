import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';
import 'package:memorycare/src/views/analise_preditiva/dominio7.dart';
import 'package:memorycare/src/views/analise_preditiva/resultadoPage.dart';

class Dominio6 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());

  final List<RxBool> respostas = List.generate(6, (_) => false.obs);

  Dominio6({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linguagem"),
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
                    "Mostre um relógio ou desenho de um relógio e pergunte: 'O que é isso?'"),
                value: respostas[0].value,
                onChanged: (bool? isChecked) {
                  respostas[0].value = isChecked ?? false;
                },
              );
            }),
            // Botão para mostrar a imagem em forma de pop-up
            ElevatedButton(
              onPressed: () {
                _showClockImageDialog(
                    context); // Mostra o pop-up com a imagem do relógio
              },
              child: const Text("Mostrar Imagem"),
            ),
            Obx(() {
              return CheckboxListTile(
                title:
                    const Text("Mostre uma caneta e pergunte: 'O que é isso?'"),
                value: respostas[1].value,
                onChanged: (bool? isChecked) {
                  respostas[1].value = isChecked ?? false;
                },
              );
            }),

            // Botão para mostrar a imagem em forma de pop-up
            ElevatedButton(
              onPressed: () {
                _showPenImageDialog(
                    context); // Mostra o pop-up com a imagem da caneta
              },
              child: const Text("Mostrar Imagem"),
            ),
            const SizedBox(height: 20),
            const Text("Repetição"),
            Obx(() {
              return CheckboxListTile(
                title:
                    const Text("Repita a frase: 'Nem aqui, nem ali, nem lá.'"),
                value: respostas[2].value,
                onChanged: (bool? isChecked) {
                  respostas[2].value = isChecked ?? false;
                },
              );
            }),

            const Text("Comando"),
            Obx(() {
              return CheckboxListTile(
                title: const Text(
                    "Vou dar três comandos. Siga-os na ordem que eu disser:"),
                value: respostas[3].value,
                onChanged: (bool? isChecked) {
                  respostas[3].value = isChecked ?? false;
                },
              );
            }),
            ElevatedButton(
              onPressed: () {
                _showCommandsDialog(context); // Mostra o pop-up com os comandos
              },
              child: const Text("Mostrar Comandos"),
            ),

            const Text("Leitura"),
            Obx(() {
              return CheckboxListTile(
                title: const Text(
                    "Mostre a frase escrita, o paciente deve ler e realizar a ação"),
                value: respostas[4].value,
                onChanged: (bool? isChecked) {
                  respostas[4].value = isChecked ?? false;
                },
              );
            }),
            ElevatedButton(
              onPressed: () {
                _showPhraseDialog(context); // Mostra o pop-up com a frase
              },
              child: const Text("Mostrar Frase"),
            ),
            const Text("Escrita"),
            Obx(() {
              return CheckboxListTile(
                title: const Text(
                    "Peça ao paciente para escrever uma frase completa de sua própria autoria."),
                value: respostas[5].value,
                onChanged: (bool? isChecked) {
                  respostas[5].value = isChecked ?? false;
                },
              );
            }),
            const Text(
                "Nota: A frase deve conter um sujeito e um objeto e fazer sentido. (Ignore erros de ortografia ao marcar o ponto)"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Conta os acertos (quantidade de checkboxes marcados)
                int acertos =
                    respostas.where((resposta) => resposta.value).length;

                // Chama o método para adicionar os pontos ao final
                if (respostas[3].value == true) {
                  analisePreditivaController.adicionarPontos(acertos + 2);
                } else {
                  analisePreditivaController.adicionarPontos(acertos);
                }

                Get.toNamed('/dominio7');
              },
              child: const Text("Próximo"),
            ),
          ],
        ),
      ),
    );
  }

  // Função para mostrar o pop-up com a imagem do relógio
  void _showClockImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(
              'assets/images/Relogio-Masculino-Analogico-Prata--Mondaine---99192G0MVNE1.png'), // Substitua pelo caminho da sua imagem
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

  void _showPenImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(
              'assets/images/caneta_esferografica_bic_cristal_dura_mais_azul_ponta_media_de_1_0mm_2637_1_671e4fdf5e2c89e777e6923939970830.png'), // Substitua pelo caminho da sua imagem
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

  void _showCommandsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Instruções'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment
                .start, // Garante que o tamanho do conteúdo não ocupe todo o espaço
            children: [
              Text("1) Pegue uma folha de papel com a mão direita."),
              Text("2) Dobre a folha ao meio."),
              Text("3) Coloque o papel na mesa."),
            ],
          ),
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

  void _showPhraseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
              "FECHE OS OLHOS"), // Substitua pelo caminho da sua imagem
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
