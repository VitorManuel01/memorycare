import 'package:flutter/material.dart';

/// Componente que representa um botão para uma tarefa.
class ButaoDeTarefas extends StatelessWidget {
  final String taskName;
  final VoidCallback onPress; // Nome da tarefa a ser exibido no botão.

  const ButaoDeTarefas({super.key, 
    required this.taskName, 
    required this.onPress,
  }); 

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFA8D5A8), // Verde-claro para o botão.
        minimumSize:
            const Size(double.infinity, 50), // Largura total e altura de 50.
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // Botões com cantos arredondados.
        ),
      ),
      onPressed: onPress,
      child: Text(
        taskName, // Exibe o nome da tarefa no botão.
        style: const TextStyle(
            fontSize: 18, color: Colors.black87), // Estilo do texto do botão.
      ),
    );
  }
}
