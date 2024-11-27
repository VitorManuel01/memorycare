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
                  controller: controller.email,
                  decoration: const InputDecoration(
                    label: Text("E-Mail"),
                    prefixIcon: Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
            Obx(
              () => TextFormField(
                controller: controller.senha,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  labelText: "Senha",
                  hintText: "Senha",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: controller.toggleObscureText,
                    icon: Icon(
                      controller.obscureText.value
                          ? Icons.remove_red_eye_sharp
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                obscureText: controller.obscureText.value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
            ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          // Tenta registrar o usuário e só navega se não houver erro
                          await SignUpController.instance.registrarUsuario(
                              controller.email.text.trim(),
                              controller.senha.text.trim());
                        }
                      },
                      child: const Text("CONTINUAR")))
            ],
          )),
    );
  }
}
