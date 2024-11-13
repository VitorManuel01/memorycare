import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/registro_dependente_controller.dart';

import '../../models/dependente.dart';


class RegistroDeDependenteForm extends StatelessWidget {
  const RegistroDeDependenteForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegistroDependenteController());

    final formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  controller: controller.nome,
                  decoration: const InputDecoration(
                    label: Text("Nome Completo"),
                    prefixIcon: Icon(Icons.person_outline_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  controller: controller.idade,
                  decoration: const InputDecoration(
                    label: Text("Idade"),
                    prefixIcon: Icon(Icons.access_time),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  controller: controller.contatoDeEmergencia,
                  decoration: const InputDecoration(
                    label: Text("Contato de Emergencia"),
                    prefixIcon: Icon(Icons.sms),
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
                  controller: controller.endereco,
                  decoration: const InputDecoration(
                    label: Text("Endereço"),
                    prefixIcon: Icon(Icons.location_on),
                  )),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                  controller: controller.cuidadorPrincipal,
                  decoration: const InputDecoration(
                    label: Text("Cuidador Principal"),
                    prefixIcon: Icon(Icons.person_pin_outlined),
                  )),
              const SizedBox(
                height: 10.0,
              ),              
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                        
                          final dependente = Dependente(
                              nome: controller.nome.text,
                              idade: int.parse(controller.idade.text),
                              contatoEmergencia: controller.contatoDeEmergencia.text,
                              telefone: controller.telefone.text,
                              endereco: controller.endereco.text,
                              cuidadorPrincipal: controller.cuidadorPrincipal.text);

                          RegistroDependenteController.instance.createDependente(dependente);
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
