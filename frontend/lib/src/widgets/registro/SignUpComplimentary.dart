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
    final controller = Get.find<SignUpController>();

    final formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                          final cuidador = Cuidadores(
                              nome: controller.nomeCompleto.text,
                              idade: int.parse(controller.idade.text),
                              parentescoFuncao:
                                  controller.parentescoFuncao.text,
                              email: controller.email.text,
                              telefone: controller.telefone.text);
                          String info = controller.nomeCompleto.text +
                              controller.idade.text +
                              controller.parentescoFuncao.text +
                              controller.email.text +
                              controller.telefone.text;

                          print("CUIDADOR DESSA PORRA: $info");

                          if (cuidador == null) {
                            print("Não existe cuidador");
                          } else {
                            SignUpController.instance.criarCuidador(cuidador);
                            SignUpController.instance.registrarUsuario(
                                controller.email.text.trim(),
                                controller.senha.text.trim());
                          }

                          SignUpController.instance.limparControladores();

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
