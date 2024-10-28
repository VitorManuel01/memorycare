import 'package:flutter/material.dart';
import 'package:memorycare/src/widgets/login/login_footer_widget.dart';
import 'package:memorycare/src/widgets/login/login_form_widget.dart';
import 'package:memorycare/src/widgets/login/login_header_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuerry = MediaQuery.of(context);
    final size = mediaQuerry.size;

    var brightness = mediaQuerry.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0XFF272727): Colors.greenAccent ,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginHeaderWidget(size: size),
                const LoginForm(),
                const LoginFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

