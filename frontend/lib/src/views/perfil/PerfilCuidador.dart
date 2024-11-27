import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/controllers/cuidadores_controller.dart';
import 'package:memorycare/src/models/cuidadores.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';
import 'package:memorycare/src/views/perfil/EditarPerfilCuidador.dart';
import 'package:memorycare/src/widgets/perfil/profile-menu-widget.dart';

class PerfilCuidador extends StatelessWidget {
  const PerfilCuidador({super.key});

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

            return Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: backgroundColor,
                leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(LineAwesomeIcons.angle_left_solid)),
                title: Text(
                  "Cuidador",
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
                                onPressed: () =>
                                    Get.to(() => const EditarPerfilCuidador()),
                                icon: const Icon(
                                  LineAwesomeIcons.pencil_alt_solid,
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
                      SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () =>
                                Get.to(() => const EditarPerfilCuidador()),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                                side: BorderSide.none,
                                shape: const StadiumBorder()),
                            child: const Text(
                              "Editar Perfil",
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      const Divider(),
                      const SizedBox(height: 10),

                      ///Menu
                      ///
                      ProfileMenuWidget(
                        titulo: 'Configurações',
                        icone: LineAwesomeIcons.cog_solid,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                        titulo: 'Faturamento e Pagamentos',
                        icone: LineAwesomeIcons.wallet_solid,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                        titulo: 'Gerenciamento de Usuário',
                        icone: LineAwesomeIcons.user_check_solid,
                        onPress: () {},
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileMenuWidget(
                        titulo: 'Informações',
                        icone: LineAwesomeIcons.info_solid,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                        titulo: 'Sair',
                        icone: LineAwesomeIcons.sign_out_alt_solid,
                        onPress: () { AuthenticationRepository.instance.logout();},
                        corDoTexto: Colors.red,
                        endIcon: false,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
