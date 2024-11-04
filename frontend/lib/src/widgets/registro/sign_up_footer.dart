import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/views/login/LoginPage.dart';

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
