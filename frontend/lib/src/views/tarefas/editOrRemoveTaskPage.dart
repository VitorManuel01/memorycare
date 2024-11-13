import 'package:flutter/material.dart';

class EditorRemoveTaskPage extends StatelessWidget {
  final String tarefaId;

  const EditorRemoveTaskPage({super.key, required this.tarefaId});

  @override
  Widget build(BuildContext context) {
    // Aqui você pode pegar os detalhes da tarefa com o `tarefaId`
    // E permitir que o usuário edite ou remova a tarefa
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Tarefa'),
      ),
      body: Center(
        child: Text('Detalhes da tarefa com ID: $tarefaId'),
      ),
    );
  }
}
