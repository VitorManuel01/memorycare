import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/widgets/common_widgets/HeaderFormWidget.dart';
import 'package:memorycare/src/widgets/registro/RegistroDeDependenteForm.dart';
import 'package:memorycare/src/widgets/registro/SignUpForm.dart';
import 'package:memorycare/src/widgets/registro/sign_up_footer.dart';

import '../../controllers/sign_up_controller.dart';
import '../../widgets/registro/SignUpComplimentary.dart';

class RegistroDependente extends StatelessWidget {
  const RegistroDependente({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0XFF272727) : Colors.greenAccent,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderFormWidget(
                  imagem: tAppLogoImage,
                  titulo: "Registre os dados do dependente",
                  subtitulo: "Seja Bem Vindo ao Memory Care",
                ),

                RegistroDeDependenteForm(), 

              ],
            ),
          ),
        ),
      ),
    );
  }
}
