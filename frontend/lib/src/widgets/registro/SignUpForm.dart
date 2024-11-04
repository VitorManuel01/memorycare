import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/sign_up_controller.dart';
// import 'package:memorycare/src/views/esqueci_a_senha/esqueci_a_senha_otp/tela_otp.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    final formKey = GlobalKey<FormState>();

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
                  controller: controller.email,
                  decoration: const InputDecoration(
                    label: Text("E-Mail"),
                    prefixIcon: Icon(Icons.email_outlined),
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
                  controller: controller.senha,
                  decoration: const InputDecoration(
                    label: Text("Senha"),
                    prefixIcon: Icon(Icons.lock_outline),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          SignUpController.instance.registrarUsuario(
                              controller.email.text.trim(),
                              controller.senha.text.trim());

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
