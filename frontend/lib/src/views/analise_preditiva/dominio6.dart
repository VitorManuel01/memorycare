import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';

class Dominio6 extends StatelessWidget {
  final analisePreditivaController = Get.put(AnalisePreditivaController());
  final List<RxBool> respostas = List.generate(6, (_) => false.obs);

  Dominio6({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linguagem"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Nomeação"),
            _buildCheckboxWithImage(
              title:
                  "Mostre um relógio ou desenho de um relógio e pergunte: 'O que é isso?'",
              index: 0,
              imageAsset:
                  'assets/images/Relogio-Masculino-Analogico-Prata--Mondaine---99192G0MVNE1.png',
              buttonLabel: "Mostrar Imagem",
              showDialog: _showClockImageDialog,
              context: context,
            ),
            _buildCheckboxWithImage(
              title: "Mostre uma caneta e pergunte: 'O que é isso?'",
              index: 1,
              imageAsset:
                  'assets/images/caneta_esferografica_bic_cristal_dura_mais_azul_ponta_media_de_1_0mm_2637_1_671e4fdf5e2c89e777e6923939970830.png',
              buttonLabel: "Mostrar Imagem",
              showDialog: _showPenImageDialog,
              context: context,
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Repetição"),
            _buildCheckbox(
                title: "Repita a frase: 'Nem aqui, nem ali, nem lá.'",
                index: 2),
            _buildSectionTitle("Comando"),
            _buildCheckboxWithImage(
              title: "Vou dar três comandos. Siga-os na ordem que eu disser:",
              index: 3,
              imageAsset: '', // Placeholder for command dialog
              buttonLabel: "Mostrar Comandos",
              showDialog: _showCommandsDialog, context: context,
            ),
            _buildSectionTitle("Leitura"),
            _buildCheckboxWithImage(
              title:
                  "Mostre a frase escrita, o paciente deve ler e realizar a ação",
              index: 4,
              imageAsset: '',
              buttonLabel: "Mostrar Frase",
              showDialog: _showPhraseDialog,
              context: context,
            ),
            _buildSectionTitle("Escrita"),
            _buildCheckbox(
                title:
                    "Peça ao paciente para escrever uma frase completa de sua própria autoria.",
                index: 5),
            const Text(
                "Nota: A frase deve conter um sujeito e um objeto e fazer sentido. (Ignore erros de ortografia ao marcar o ponto)"),
            const SizedBox(height: 20),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
      ),
    );
  }

  Widget _buildCheckbox({required String title, required int index}) {
    return Obx(() {
      return CheckboxListTile(
        title: Text(title),
        value: respostas[index].value,
        onChanged: (bool? isChecked) {
          respostas[index].value = isChecked ?? false;
        },
        activeColor: Colors.teal,
      );
    });
  }

  Widget _buildCheckboxWithImage({
    required String title,
    required int index,
    required String imageAsset,
    required String buttonLabel,
    required Function(BuildContext) showDialog,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return CheckboxListTile(
            title: Text(title),
            value: respostas[index].value,
            onChanged: (bool? isChecked) {
              respostas[index].value = isChecked ?? false;
            },
            activeColor: Colors.teal,
          );
        }),
        ElevatedButton.icon(
          onPressed: () {
            showDialog(context);
          },
          icon: Icon(Icons.image),
          label: Text(buttonLabel),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          int acertos = respostas.where((resposta) => resposta.value).length;
          if (respostas[3].value == true) {
            analisePreditivaController.adicionarPontos(acertos + 2);
          } else {
            analisePreditivaController.adicionarPontos(acertos);
          }
          Get.toNamed('/dominio7');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          padding: EdgeInsets.symmetric(vertical: 15.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          "Próximo",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void _showClockImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.asset(
              'assets/images/Relogio-Masculino-Analogico-Prata--Mondaine---99192G0MVNE1.png'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
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
              'assets/images/caneta_esferografica_bic_cristal_dura_mais_azul_ponta_media_de_1_0mm_2637_1_671e4fdf5e2c89e777e6923939970830.png'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
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
            children: [
              Text("1) Pegue uma folha de papel com a mão direita."),
              Text("2) Dobre a folha ao meio."),
              Text("3) Coloque o papel na mesa."),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
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
          content: const Text("FECHE OS OLHOS"),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
