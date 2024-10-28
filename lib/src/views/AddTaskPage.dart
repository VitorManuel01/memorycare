import 'package:flutter/material.dart';

/// Página para adicionar novas tarefas.
class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estrutura básica com barra de app e corpo da página.
      appBar: AppBar(
        title: const Text('Adicionar Tarefa'), // Título na barra de app.
        backgroundColor: Colors.green, // Cor verde para a barra de app.
      ),
      body: const Center(
        // Centraliza o conteúdo da página.
        child: Text(
          'Página para adicionar novas tarefas', // Texto informativo.
          style: TextStyle(fontSize: 18), // Estilo do texto.
        ),
      ),
    );
  }
}