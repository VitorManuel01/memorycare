import 'package:flutter/material.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/widgets/common_widgets/HeaderFormWidget.dart';
import 'package:memorycare/src/widgets/login/login_footer_widget.dart';
import 'package:memorycare/src/widgets/login/login_form_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuerry = MediaQuery.of(context);

    var brightness = mediaQuerry.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            isDarkMode ? const Color(0XFF272727) : Colors.greenAccent,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderFormWidget(
                  imagem: tAppLogoImage,
                  titulo: "Bem Vindo de volta!",
                  subtitulo: "Faça login para continuar sua jornada de cuidado e memória.",
                ),
                LoginForm(),
                LoginFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
