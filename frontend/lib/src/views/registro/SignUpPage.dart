import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/widgets/common_widgets/HeaderFormWidget.dart';
import 'package:memorycare/src/widgets/registro/SignUpForm.dart';
import 'package:memorycare/src/widgets/registro/sign_up_footer.dart';

import '../../controllers/sign_up_controller.dart';
import '../../widgets/registro/SignUpComplimentary.dart';

class Signuppage extends StatelessWidget {
  const Signuppage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    final SignUpController signupController = Get.put(SignUpController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0XFF272727) : Colors.greenAccent,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderFormWidget(
                  imagem: tAppLogoImage,
                  titulo: "Faça o registro no nosso App",
                  subtitulo: "Seja Bem Vindo ao Memory Care",
                ),
                Obx(() => signupController.exibirFormComplementar.value 
                    ? const SignUpFormComplementary() 
                    : const SignUpForm()
                ),
                const SignUpFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

