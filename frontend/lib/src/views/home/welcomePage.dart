import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/views/login/LoginPage.dart';
import 'package:memorycare/src/views/registro/SignUpPage.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuerry = MediaQuery.of(context);
    var height = mediaQuerry.size.height;
    var brightness = mediaQuerry.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0XFF272727): Colors.greenAccent ,
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: const AssetImage(tAppLogoImage),
              height: height * 0.6,
            ),
            Column(
              children: [
                Text("Memory Care",
                    style: Theme.of(context).textTheme.headlineLarge),
                Text(
                  "Bem Vindo ao Memory Care App, um app de assistência à idosos com dificuldades de memória",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
             Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () => Get.to(() => const LoginPage()), child: const Text("LOGIN"))),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () => Get.to(() => const Signuppage()), child: const Text("REGISTRAR")))
                ],
              ),

          ],
        ),
      ),
    );
  }
}
