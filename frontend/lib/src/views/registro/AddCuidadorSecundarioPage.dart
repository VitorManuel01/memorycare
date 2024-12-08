import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/cuidadores_secundarios_controller.dart';
import 'package:memorycare/src/widgets/registro/RegistroCuidSecForm.dart';

class AddCuidadorSecundarioPage extends StatelessWidget {
  const AddCuidadorSecundarioPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CuidadoresSecundariosController());

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Cuidador Secundário'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: AddCuidSecForm(formKey: formKey, controller: controller),
        ),
      ),
    );
  }
}

