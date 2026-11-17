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
        backgroundColor: Colors.teal,
        title: const Text("Habilidade Visuoespacial"),
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Nomeação",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return CheckboxListTile(
                title: const Text(
                  "Mostre ao paciente uma figura de dois pentágonos que se interseccionam.",
                  style: TextStyle(fontSize: 16),
                ),
                value: respostas[0].value,
                onChanged: (bool? isChecked) {
                  respostas[0].value = isChecked ?? false;
                },
                activeColor: Colors.teal,
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              );
            }),
            const SizedBox(height: 10),
            const Text(
              "Peça ao paciente para copiar o desenho.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showPentagonsImageDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Mostrar Imagem",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  int acertos = respostas.where((resposta) => resposta.value).length;
                  analisePreditivaController.adicionarPontos(acertos);
                  analisePreditivaController.determinarResultado();
                  Get.toNamed('/resultado');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Finalizar",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPentagonsImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Peça ao paciente para copiar o desenho.',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Image.asset(
            'assets/images/pentagonos.PNG', // Substitua pelo caminho da sua imagem
            fit: BoxFit.contain,
            height: 250,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Fecha o pop-up
              },
              child: const Text(
                'Fechar',
                style: TextStyle(fontSize: 16, color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }
}
