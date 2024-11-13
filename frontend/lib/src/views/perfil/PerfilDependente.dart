import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/views/perfil/EditarPerfilDependente.dart';

class PerfilDependente extends StatelessWidget {
  const PerfilDependente({super.key});

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
          "Perfil do Dependente",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Foto de perfil
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(image: AssetImage(tFotoDePerfil)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const DependenteInfo(
                nomeCompleto: '',
                idade: 0,
                telefone: '',
                contatoEmergencia: '',
                residencia: '',
                cuidadorPrincipal: '',
              ),

              // Botão de edição
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Redireciona para a página de edição do perfil
                    Get.to(() => const EditarPerfilDependente());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(
                    "Editar Perfil",
                    style: TextStyle(color: Colors.black),
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

class DependenteInfo extends StatelessWidget {
  const DependenteInfo({
    super.key,
    required this.nomeCompleto,
    required this.idade,
    required this.telefone,
    required this.contatoEmergencia,
    required this.residencia,
    required this.cuidadorPrincipal,
  });
  final String nomeCompleto;
  final int idade;
  final String telefone;
  final String contatoEmergencia;
  final String residencia;
  final String cuidadorPrincipal;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          nomeCompleto,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(LineAwesomeIcons.user),
          title: const Text("Nome Completo"),
          subtitle: Text(nomeCompleto),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(LineAwesomeIcons.calendar),
          title: const Text("Idade"),
          subtitle: Text(idade.toString()),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(LineAwesomeIcons.phone_solid),
          title: const Text("Telefone"),
          subtitle: Text(telefone),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(LineAwesomeIcons.phone_solid),
          title: const Text("Contato de Emergência"),
          subtitle: Text(contatoEmergencia),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(LineAwesomeIcons.map),
          title: const Text("Endereço"),
          subtitle: Text(residencia),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(LineAwesomeIcons.user_friends_solid),
          title: const Text("Cuidador Principal"),
          subtitle: Text(cuidadorPrincipal),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
