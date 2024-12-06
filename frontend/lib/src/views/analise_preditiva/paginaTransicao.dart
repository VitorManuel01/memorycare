import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/views/analise_preditiva/dominio1.dart';

class PaginaTransicaoAnalise extends StatelessWidget {
  const PaginaTransicaoAnalise({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste Cognitivo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Olá, realize o Teste Cognitivo do paciente\n'
              'Lembre-se de assinalar somente aquilo que houve acerto!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navega para a página Dominio1 e remove todas as páginas anteriores da pilha
                Get.offAll(() => Dominio1());
              },
              child: const Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
