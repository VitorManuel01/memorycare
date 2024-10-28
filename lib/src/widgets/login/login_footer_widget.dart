import 'package:flutter/material.dart';
import 'package:memorycare/src/constants/image_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
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
          onPressed: () {},
          child: Text.rich(
            TextSpan(
              text: "Não tem uma conta?",
              style: Theme.of(context).textTheme.bodySmall,
              children: const [
                TextSpan(
                    text: " Registrar",
                    style: TextStyle(color: Colors.blue))
              ],
            ),
          ),
        )
      ],
    );
  }
}
