import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';
import 'package:memorycare/src/views/perfil/PerfilDependente.dart';

import '../tarefas/Tarefas.dart';
import '../perfil/PerfilCuidador.dart';

/// A classe HomePage define a tela principal do aplicativo.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Pegando as informações de MediaQuery
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    final backgroundColor = isDarkMode ? const Color(0XFF272727) : Colors.greenAccent;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle:
                TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search,
                color: isDarkMode ? Colors.white : Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red, size: 30),
            onPressed: () {
              AuthenticationRepository.instance.logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Memory Care',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        'Online 1-on-1 Tutoring',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.greenAccent,
                          backgroundColor: isDarkMode
                              ? const Color(0x000651bd)
                              : Colors.white,
                        ),
                        child: Text(
                          'Learn More',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 9,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
              padding: const EdgeInsets.all(16.0),
              itemCount: 4, // Total de cards
              itemBuilder: (context, index) {
                // Lista de botões com ícones e seus respectivos nomes e páginas
                final List<Map<String, dynamic>> pages = [
                  {
                    'name': 'Tarefas',
                    'icon': Icons.assignment,
                    'page': const Tarefas(),
                  },
                  {
                    'name': 'Perfil Cuidador',
                    'icon': Icons.person,
                    'page': const PerfilCuidador(),
                  },
                  {
                    'name': 'Perfil Dependente',
                    'icon': Icons.elderly,
                    'page': const PerfilDependente(), // Ajuste conforme necessário
                  },
                  {
                    'name': 'Cuidadores Secundários',
                    'icon': Icons.person_pin,
                    'page': const Tarefas(), // Ajuste conforme necessário
                  },
                ];

                final page = pages[index];

                return InkWell(
                  onTap: () {
                    // Redireciona para a página correspondente usando Get.to() corretamente
                    Get.to(page['page']);
                  },
                  splashColor:
                      Colors.blue.withOpacity(0.3), // Cor do efeito de splash
                  highlightColor: Colors.blue
                      .withOpacity(0.1), // Cor do efeito de highlight
                  child: Card(
                    elevation: 5, // Adiciona sombra no card
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // Cantos arredondados
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          page['icon'], // Ícone específico de cada card
                          size: 50, // Tamanho do ícone
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            page['name'], // Nome do card
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize:
                                          20, // Ajuste de tamanho conforme necessário
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
