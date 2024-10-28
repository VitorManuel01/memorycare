import 'package:flutter/material.dart';
import 'package:memorycare/src/widgets/taskButton.dart';

/// A classe HomePage define a tela principal do aplicativo.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // `Scaffold` é uma estrutura básica que contém a barra de app e o corpo da página.
      backgroundColor: const Color(0xFFB7D3A8), // Define a cor de fundo (verde-claro).
      body: SafeArea(
        // `SafeArea` evita que o conteúdo fique sobreposto à barra de status do dispositivo.
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Adiciona espaçamento interno em todos os lados.
          child: Column(
            // Exibe os widgets verticalmente, um abaixo do outro.
            crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o conteúdo horizontalmente.
            children: [
              // Linha que contém o título e o botão de adicionar tarefa.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribui os itens com espaço entre eles.
                children: [
                  const Text(
                    'Segunda-Feira', // Exibe o nome do dia da semana.
                    style: TextStyle(
                      fontSize: 20, // Define o tamanho da fonte.
                      color: Colors.black87, // Define a cor do texto.
                    ),
                  ),
                  // Botão de adicionar tarefa, usando um ícone de "+".
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.green, size: 30),
                    // Ao pressionar o botão, navega para a página de adicionar tarefa.
                    onPressed: () {
                      Navigator.pushNamed(context, '/add-task');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20), // Adiciona um espaçamento vertical.
              // Exibe o relógio na tela.
              const Text(
                '00:00', // Valor fixo apenas como exemplo.
                style: TextStyle(
                  fontSize: 60, // Tamanho grande para simular um relógio.
                  fontWeight: FontWeight.bold, // Define a fonte como negrito.
                  color: Colors.white, // Cor branca para o texto.
                ),
              ),
              const SizedBox(height: 10), // Espaçamento entre o relógio e o texto abaixo.
              const Text(
                'Convidar', // Texto "Convidar" abaixo do relógio.
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 30), // Mais um espaçamento vertical.
              // Container expandido que ocupa o espaço disponível e exibe a lista de tarefas.
              Expanded(
                child: Container(
                  // Container com cor de fundo e bordas arredondadas na parte superior.
                  decoration: const BoxDecoration(
                    color: Color(0xFF507D5A), // Verde-escuro para o fundo.
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(40), // Bordas arredondadas no topo.
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0), // Espaçamento interno no container.
                    child: Column(
                      // Exibe os itens (título e botões de tarefa) na vertical.
                      children: [
                        Text(
                          'Tarefas', // Título "Tarefas".
                          style: TextStyle(
                            fontSize: 24, // Tamanho maior para destacar o título.
                            fontWeight: FontWeight.bold, // Negrito.
                            color: Colors.white, // Cor branca.
                          ),
                        ),
                        SizedBox(height: 20), // Espaçamento abaixo do título.
                        TaskButton(taskName: 'Tarefa 01'), // Botão para a primeira tarefa.
                        SizedBox(height: 10), // Espaçamento entre os botões.
                        TaskButton(taskName: 'Tarefa 02'), // Botão para a segunda tarefa.
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
