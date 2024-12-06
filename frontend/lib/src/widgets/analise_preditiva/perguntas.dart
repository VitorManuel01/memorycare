import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Perguntas extends StatelessWidget {
  final String dominio;
  final List<String> perguntas;
  final Function(int) onConcluir;

  Perguntas({
    required this.dominio,
    required this.perguntas,
    required this.onConcluir,
  });

  @override
  Widget build(BuildContext context) {
    final respostas = List<bool>.filled(perguntas.length, false).obs; // Usando GetX para gerenciar o estado das respostas

    return Scaffold(
      appBar: AppBar(title: Text(dominio)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: perguntas.length,
              itemBuilder: (context, index) {
                return Obx(() => CheckboxListTile(
                      title: Text(perguntas[index]),
                      value: respostas[index],
                      onChanged: (bool? valor) {
                        if (valor != null) {
                          respostas[index] = valor; // Atualiza a resposta com GetX
                        }
                      },
                    ));
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Conta quantos checkboxes foram marcados como verdadeiros
              final pontos = respostas.where((resposta) => resposta).length;
              onConcluir(pontos); // Chama o callback com a pontuação calculada
            },
            child: Text("Próximo"),
          ),
        ],
      ),
    );
  }
}
