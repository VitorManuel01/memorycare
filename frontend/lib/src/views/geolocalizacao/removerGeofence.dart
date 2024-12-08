import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/controllers/areas_controller.dart';

class TelaRemoverArea {
  static Future<dynamic> buildShowModalBottomSheet(
      BuildContext context, String idArea, String identifier) {
    final ConfigurarAreaController controller =
        Get.put(ConfigurarAreaController());
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Deseja apagar esta área?.",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 30.0),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.excluirArea(idArea, identifier);
                    },
                    child: const Text("REMOVER")))
          ],
        ),
      ),
    );
  }
}
