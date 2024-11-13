import 'package:flutter/material.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/widgets/common_widgets/HeaderFormWidget.dart';
import 'package:memorycare/src/widgets/registro/SignUpForm.dart';
import 'package:memorycare/src/widgets/registro/sign_up_footer.dart';


class Signuppage extends StatelessWidget {
  const Signuppage({super.key});

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
                  titulo: "Faça o registro no nosso App",
                  subtitulo: "Seja Bem Vindo ao Memory Care",
                ),

                SignUpForm(),
                SignUpFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

