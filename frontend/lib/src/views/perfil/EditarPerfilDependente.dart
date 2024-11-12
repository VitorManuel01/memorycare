import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
              icon: Icon(
                  isDarkMode ? LineAwesomeIcons.moon : LineAwesomeIcons.sun))
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
                        child: const Image(image: AssetImage(tFotoDePerfil))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: isDarkMode ? Colors.grey : Colors.yellow),
                      child: IconButton(
                        onPressed: () =>
                            Get.to(() => const EditarPerfilDependente()),
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
                "Nome do Dependente",
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
                      decoration: const InputDecoration(
                    label: Text("Nome Completo"),
                    prefixIcon: Icon(Icons.person_outline_outlined),
                  )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                    label: Text("Idade"),
                    prefixIcon: Icon(LineAwesomeIcons.calendar),
                  )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                    label: Text("Telefone"),
                    prefixIcon: Icon(Icons.phone),
                  )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                    label: Text("Contato de Emergência"),
                    prefixIcon: Icon(Icons.phone),
                  )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                    label: Text("Endereço"),
                    prefixIcon: Icon(Icons.map),
                  )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                      decoration: const InputDecoration(
                    label: Text("Parentesco / Função do Cuidador"),
                    prefixIcon: Icon(Icons.people_outline),
                  )),
                  const SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const EditarPerfilDependente()),
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
}
