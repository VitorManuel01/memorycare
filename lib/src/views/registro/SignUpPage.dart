import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/views/login/LoginPage.dart';
import 'package:memorycare/src/widgets/common_widgets/HeaderFormWidget.dart';
import 'package:memorycare/src/widgets/registro/SignUpForm.dart';

class Signuppage extends StatelessWidget {
  const Signuppage({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderFormWidget(
                  imagem: tAppLogoImage,
                  titulo: "Faça o registro no nosso App",
                  subtitulo: "Seja Bem Vindo ao Memory Care",
                ),
                const SignUpForm(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("OU"),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Image(
                          image: AssetImage(tGoogleLogoImage),
                          width: 20.0,
                        ),
                        onPressed: () {},
                        label: const Text("Realizar Login com Google"),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.to(()=> const LoginPage()),
                      child: Text.rich(
                        TextSpan(
                          text: "Já tem uma conta?",
                          style: Theme.of(context).textTheme.bodySmall,
                          children: const [
                            TextSpan(
                                text: " Login",
                                style: TextStyle(color: Colors.blue))
                          ],
                        ),
                      ),
                    )
                  ],
                )
                //LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
