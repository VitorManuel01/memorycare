import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:memorycare/src/controllers/cuidadores_controller.dart';
import 'package:memorycare/src/models/cuidadores.dart';
import 'package:memorycare/src/views/home/HomePage.dart';

import '../../constants/image_strings.dart';

class EditarPerfilCuidador extends StatelessWidget {
  const EditarPerfilCuidador({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    final backgroundColor =
        isDarkMode ? const Color(0XFF272727) : Colors.greenAccent;

    final CuidadoresController cuidadoresController =
        Get.put(CuidadoresController());

    // Função assíncrona para obter o UID do usuário autenticado
    Future<String?> obterUidUsuario() async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        return uid;
      } else {
        return null;
      }
    }

    return FutureBuilder<Cuidadores>(
        future: cuidadoresController.getCuidador(obterUidUsuario().toString()),
        builder: (BuildContext context, AsyncSnapshot<Cuidadores> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text("Erro ao carregar cuidador: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Cuidador não encontrado"));
          } else {
            Cuidadores cuidador = snapshot.data!;

            final TextEditingController nomeController =
                TextEditingController(text: cuidador.nome);
            final TextEditingController idadeController =
                TextEditingController(text: cuidador.idade.toString());
            final TextEditingController emailController =
                TextEditingController(text: cuidador.email);
            final TextEditingController telefoneController =
                TextEditingController(text: cuidador.telefone);
            final TextEditingController parentescoController =
                TextEditingController(text: cuidador.parentescoFuncao);

            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: backgroundColor,
                leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(LineAwesomeIcons.angle_left_solid)),
                title: Text(
                  "Editar Perfil",
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
                                onPressed: () => Get.to(() => const HomePage()),
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
                        cuidador.nome,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      Text(
                        cuidador.email!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Divider(),
                      const SizedBox(height: 10),

                      ///Form
                      ///
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
                              controller: emailController,
                              decoration: const InputDecoration(
                                label: Text("E-Mail"),
                                prefixIcon: Icon(Icons.email_outlined),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                              controller: telefoneController,
                              decoration: const InputDecoration(
                                label: Text("Telefone"),
                                prefixIcon: Icon(Icons.phone_android_outlined),
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
                              controller: parentescoController,
                              decoration: const InputDecoration(
                                label: Text("Parentesco / Função"),
                                prefixIcon: Icon(Icons.phone_android_outlined),
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Cuidadores cuidador = Cuidadores(
                                  //     nome: nomeController.text,
                                  //     idade: int.parse(idadeController.text),
                                  //     parentescoFuncao:
                                  //         parentescoController.text,
                                  //     email: emailController.text,
                                  //     telefone: telefoneController.text);

                                  
                                  Get.to(() => const HomePage());
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.yellow,
                                    side: BorderSide.none,
                                    shape: const StadiumBorder()),
                                child: const Text(
                                  "Editar Perfil",
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
