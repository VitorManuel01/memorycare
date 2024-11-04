import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/login_controller.dart';
import 'package:memorycare/src/views/esqueci_a_senha/esqueci_a_senha_options/tela_esqueci_a_senha_opcoes.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "Email",
                hintText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira o email';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
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
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  TelaEsqueciASenha.buildShowModalBottomSheet(context);
                },
                child: const Text("Esqueci a Senha"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Chama a função de login se o formulário for válido
                    LoginController.instance.login(
                      controller.email.text.trim(),
                      controller.senha.text.trim(),
                    );
                  }
                },
                child: const Text("LOGIN"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
