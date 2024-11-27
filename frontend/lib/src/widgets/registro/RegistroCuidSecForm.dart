import 'package:flutter/material.dart';
import 'package:memorycare/src/controllers/cuidadores_secundarios_controller.dart';
import 'package:memorycare/src/models/cuidadoresSucundarios.dart';

class AddCuidSecForm extends StatelessWidget {
  AddCuidSecForm({
    super.key,
    required this.formKey,
    required this.controller,
  });

  final GlobalKey<FormState> formKey;
  final CuidadoresSecundariosController controller;

  final TextEditingController nomeCompletoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController parentescoFuncaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: nomeCompletoController,
                decoration: const InputDecoration(
                  label: Text("Nome Completo"),
                  prefixIcon: Icon(Icons.person_outline_outlined),
                )),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
                controller: telefoneController,
                decoration: const InputDecoration(
                  label: Text("Telefone"),
                  prefixIcon: Icon(Icons.phone_android_outlined),
                )),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
                controller: idadeController,
                decoration: const InputDecoration(
                  label: Text("Idade"),
                  prefixIcon: Icon(Icons.person_outline_outlined),
                )),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
                controller: parentescoFuncaoController,
                decoration: const InputDecoration(
                  label: Text("Parentesco / Função"),
                  prefixIcon: Icon(Icons.email_outlined),
                )),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  label: Text("Email"),
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
                        final cuidadorSecundario = CuidadoresSecundarios(
                            nome: nomeCompletoController.text,
                            idade: int.parse(idadeController.text),
                            parentescoFuncao: parentescoFuncaoController.text,
                            email: emailController.text,
                            telefone: telefoneController.text);

                        CuidadoresSecundariosController.instance
                            .createCuidadorSecundario(cuidadorSecundario);
                      }
                    },
                    child: const Text("REGISTRAR")))
          ],
        ));
  }
}
