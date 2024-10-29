import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/constants/image_strings.dart';
import 'package:memorycare/src/views/esqueci_a_senha/esqueci_a_senha_otp/tela_otp.dart';
import 'package:memorycare/src/widgets/common_widgets/HeaderFormWidget.dart';

class TelaEsqueciSenhaPhone extends StatelessWidget {
  const TelaEsqueciSenhaPhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const SizedBox(
            height: 30 * 4,
          ),
          const HeaderFormWidget(
            imagem: tForgetPasswordImage,
            titulo: "Digite seu Telefone",
            subtitulo: "Digite seu Telefone para realizar o reset de sua senha",
            crossAxisAlignment: CrossAxisAlignment.center,
            heightBetween: 30,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Form(
              child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: "Senha",
                    hintText: "Senha",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => const TelaOTP());
                    },
                    child: const Text("Próximo")),
              )
            ],
          ))
        ],
      ),
    ));
  }
}
