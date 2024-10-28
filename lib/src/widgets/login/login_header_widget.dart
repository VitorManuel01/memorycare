import 'package:flutter/material.dart';
import 'package:memorycare/src/constants/image_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: const AssetImage(tAppLogoImage),
          height: size.height * 0.2,
        ),
        Text(
          "Bem Vindo de volta!",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          "Faça login para continuar sua jornada de cuidado e memória.",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}