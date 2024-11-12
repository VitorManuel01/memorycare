import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';
import 'package:memorycare/src/views/AddTaskPage.dart';
import 'package:memorycare/src/widgets/taskButton.dart';

class Tarefas extends StatelessWidget {
  const Tarefas({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final backgroundColor =
        isDarkMode ? const Color(0XFF272727) : Colors.greenAccent;

    return Scaffold(
      // `Scaffold` é uma estrutura básica que contém a barra de app e o corpo da página.
      backgroundColor: isDarkMode
          ? const Color(0XFF272727)
          : const Color(0xFFB7D3A8), // Define a cor de fundo (verde-claro).
      body: SafeArea(
        // `SafeArea` evita que o conteúdo fique sobreposto à barra de status do dispositivo.
        child: Padding(
          padding: const EdgeInsets.all(
              16.0), // Adiciona espaçamento interno em todos os lados.
          child: Column(
            // Exibe os widgets verticalmente, um abaixo do outro.
            crossAxisAlignment: CrossAxisAlignment
                .center, // Centraliza o conteúdo horizontalmente.
            children: [
              // Linha que contém o título, o botão de adicionar tarefa e o botão de logout.
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Distribui os itens com espaço entre eles.
                children: [
                  const Text(
                    'Segunda-Feira', // Exibe o nome do dia da semana.
                    style: TextStyle(
                      fontSize: 20, // Define o tamanho da fonte.
                      color: Colors.black87, // Define a cor do texto.
                    ),
                  ),
                  Row(
                    children: [
                      // Botão de adicionar tarefa, usando um ícone de "+".
                      IconButton(
                        icon: const Icon(Icons.add,
                            color: Colors.green, size: 30),
                        // Ao pressionar o botão, navega para a página de adicionar tarefa.
                        onPressed: () {
                          Get.to(() => const AddTaskPage());
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20), // Adiciona um espaçamento vertical.
              // Exibe o relógio na tela.
              const Text(
                '00:00', // Valor fixo apenas como exemplo.
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Convidar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 30),

              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color.fromARGB(255, 66, 66, 66)
                        : const Color(0xFF507D5A),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(40), // Bordas arredondadas no topo.
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(
                        16.0), // Espaçamento interno no container.
                    child: Column(
                      // Exibe os itens (título e botões de tarefa) na vertical.
                      children: [
                        Text(
                          'Tarefas', // Título "Tarefas".
                          style: TextStyle(
                            fontSize:
                                24, // Tamanho maior para destacar o título.
                            fontWeight: FontWeight.bold, // Negrito.
                            color: Colors.white, // Cor branca.
                          ),
                        ),
                        SizedBox(height: 20), // Espaçamento abaixo do título.
                        TaskButton(
                            taskName:
                                'Tarefa 01'), // Botão para a primeira tarefa.
                        SizedBox(height: 10), // Espaçamento entre os botões.
                        TaskButton(
                            taskName:
                                'Tarefa 02'), // Botão para a segunda tarefa.
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
