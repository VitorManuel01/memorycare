import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/sign_up_controller.dart';

import '../../models/cuidadores.dart';

class SignUpFormComplementary extends StatelessWidget {
  const SignUpFormComplementary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    final formKey = GlobalKey<FormState>();

    String? obterEmailUsuario() {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String? userEmail = user.email;
        
        return userEmail.toString();
      } else {
        return null;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  controller: controller.nomeCompleto,
                  decoration: const InputDecoration(
                    label: Text("Nome Completo"),
                    prefixIcon: Icon(Icons.person_outline_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  controller: controller.telefone,
                  decoration: const InputDecoration(
                    label: Text("Telefone"),
                    prefixIcon: Icon(Icons.phone_android_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  controller: controller.idade,
                  decoration: const InputDecoration(
                    label: Text("Idade"),
                    prefixIcon: Icon(Icons.person_outline_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  controller: controller.parentescoFuncao,
                  decoration: const InputDecoration(
                    label: Text("Parentesco / Função"),
                    prefixIcon: Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final String? emailUser = obterEmailUsuario();
                          final cuidador = Cuidadores(
                              nome: controller.nomeCompleto.text,
                              idade: int.parse(controller.idade.text),
                              parentescoFuncao:
                              controller.parentescoFuncao.text,
                              email: emailUser,
                              telefone: controller.telefone.text);

                          SignUpController.instance.criarCuidador(cuidador);

                          // SignUpController.instance.autenticarPorTelefone(
                          //     controller.telefone.text.trim());
                          // Get.to(() => const TelaOTP());
                        }
                      },
                      child: const Text("REGISTRAR")))
            ],
          )),
    );
  }
}
