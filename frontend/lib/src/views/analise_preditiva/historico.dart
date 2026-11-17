import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memorycare/src/controllers/analise_preditiva_controller.dart';
import 'package:memorycare/src/models/analise_preditiva.dart';
import 'package:memorycare/src/views/home/HomePage.dart';
import 'package:memorycare/src/widgets/analise_preditiva/TesteInfoWidget.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnalisePreditivaController());
    return Scaffold(
      appBar: AppBar(title: const Text("Histórico de Testes")),
      body: StreamBuilder<List<AnalisePreditiva>>(
          stream: controller
              .listaDeTestes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Sem testes'));
            }

            final testes = snapshot.data!;
            return ListView.builder(
              itemCount: testes.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                final teste = testes[index];
                Timestamp? dataConclusao = teste.dataConclusao;

                String dataFormatada = dataConclusao != null
                    ? DateFormat('dd/MM/yyyy HH:mm')
                        .format(dataConclusao.toDate())
                    : 'Sem data';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: TesteInfoWidget(
                    dataConclusao: dataFormatada,
                    pontuacao: teste.pontuacaoTotal.toString(),
                    resultado: teste.resultado,
                    semanaDoAno: teste.semana.toString(),
                  ),
                );
              },
            );
          }),
    );
  }
}

// Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Pontuação: ${controller.pontuacaoTotal.value}"),
//                   Text("Resultado: ${controller.resultado}"),
//                   ElevatedButton(
//                     onPressed: () {
//                       controller.salvarResultados(
//                           controller.pontuacaoTotal.value,
//                           controller.resultado.value);
//                       controller.resetar();
//                       Get.offAll(() => const HomePage());
//                     },
//                     child: const Text("Finalizar"),
//                   ),
//                 ],
//               ),
//             );