import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:memorycare/src/controllers/dependente_controller.dart';
import 'package:memorycare/src/models/dependente.dart';
import 'package:memorycare/src/views/home/HomePage.dart';

import '../../constants/image_strings.dart';

class EditarPerfilDependente extends StatelessWidget {
  const EditarPerfilDependente({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    final backgroundColor =
        isDarkMode ? const Color(0XFF272727) : Colors.greenAccent;
    final DependenteController dependenteController =
        Get.put(DependenteController());

    return FutureBuilder<Dependente>(
        future: dependenteController.getDependente(),
        builder: (BuildContext context, AsyncSnapshot<Dependente> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Erro ao carregar dependente: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Dependente não encontrado"));
          } else {
            Dependente dependente = snapshot.data!;

            final TextEditingController nomeController =
                TextEditingController(text: dependente.nome);
            final TextEditingController idadeController =
                TextEditingController(text: dependente.idade.toString());
            final TextEditingController contatoDeEmergenciaController =
                TextEditingController(text: dependente.contatoEmergencia);
            final TextEditingController telefoneController =
                TextEditingController(text: dependente.telefone);
            final TextEditingController enderecoController =
                TextEditingController(text: dependente.endereco);
            final TextEditingController cuidadorPrincipalController =
                TextEditingController(text: dependente.cuidadorPrincipal);

            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: backgroundColor,
                leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(LineAwesomeIcons.angle_left_solid)),
                title: Text(
                  "Editar Perfil do Dependente",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(isDarkMode
                          ? LineAwesomeIcons.moon
                          : LineAwesomeIcons.sun))
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const Image(
                                    image: AssetImage(tFotoDePerfil))),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color:
                                      isDarkMode ? Colors.grey : Colors.yellow),
                              child: IconButton(
                                onPressed: () => Get.to(
                                    () => const EditarPerfilDependente()),
                                icon: const Icon(
                                  LineAwesomeIcons.camera_solid,
                                  size: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        dependente.nome,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        "Informações Adicionais",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(),
                      const SizedBox(height: 10),

                      /// Formulário para editar informações do dependente
                      Form(
                          child: Column(
                        children: [
                          TextFormField(
                              controller: nomeController,
                              decoration: const InputDecoration(
                                label: Text("Nome Completo"),
                                prefixIcon: Icon(Icons.person_outline_outlined),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                              controller: idadeController,
                              decoration: const InputDecoration(
                                label: Text("Idade"),
                                prefixIcon: Icon(LineAwesomeIcons.calendar),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                              controller: telefoneController,
                              decoration: const InputDecoration(
                                label: Text("Telefone"),
                                prefixIcon: Icon(Icons.phone),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                              controller: contatoDeEmergenciaController,
                              decoration: const InputDecoration(
                                label: Text("Contato de Emergência"),
                                prefixIcon: Icon(Icons.phone),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                              controller: enderecoController,
                              decoration: const InputDecoration(
                                label: Text("Endereço"),
                                prefixIcon: Icon(Icons.map),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                              controller: cuidadorPrincipalController,
                              decoration: const InputDecoration(
                                label: Text("Cuidador Principal"),
                                prefixIcon: Icon(Icons.people_outline),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Criação da tarefa
                                  Dependente dependente = Dependente(
                                    nome: nomeController.text,
                                    idade: int.parse(idadeController.text),
                                    telefone: telefoneController.text,
                                    contatoEmergencia:
                                        contatoDeEmergenciaController.text,
                                    endereco: enderecoController.text,
                                    cuidadorPrincipal:
                                        cuidadorPrincipalController.text,
                                  );

                                  // Envia a tarefa para o controller salvar
                                  dependenteController
                                      .editarDependente(dependente);

                                  // Exibe uma mensagem de sucesso

                                  // Navega para a página inicial ou outra página desejada
                                  Get.to(() => const HomePage());
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text(
                                  "Salvar Alterações",
                                  style: TextStyle(color: Colors.black),
                                ),
                              )),
                        ],
                      ))
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
