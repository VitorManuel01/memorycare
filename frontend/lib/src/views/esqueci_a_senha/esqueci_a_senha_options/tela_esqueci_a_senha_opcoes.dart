import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/views/esqueci_a_senha/esqueci_a_senha_email/esqueci_a_senha_email.dart';
import 'package:memorycare/src/views/esqueci_a_senha/esqueci_a_senha_phone/esqueci_a_senha_phone.dart';
import 'package:memorycare/src/widgets/esqueci_a_senha/EsqueciSenhaButton.dart';

class TelaEsqueciASenha {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selecione uma opção!",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text("Selecione uma das opões para resetar sua senha.",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 30.0),
            EsqueciSenhaButton(
              titulo: 'E-Mail',
              subtitulo: 'Resetar via Verificação de E-Mail',
              icone: Icons.email_outlined,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const TelaEsqueciSenhaEmail());
              },
            ),
            const SizedBox(
              height: 60,
            ),
            EsqueciSenhaButton(
              titulo: "Telefone",
              subtitulo: "Resetar via verificação Telefone",
              icone: Icons.phone_android_outlined,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const TelaEsqueciSenhaPhone());
              },
            )
          ],
        ),
      ),
    );
  }
}
