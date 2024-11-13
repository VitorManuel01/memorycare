import 'package:get/get.dart';
import 'package:memorycare/src/models/tarefa.dart';
import 'package:memorycare/src/repository/dependente/tarefas_repository.dart';

class TarefasController extends GetxController {
  static TarefasController get instance => Get.find();

  final tarefaRepo = Get.put(TarefasRepository());

  Stream<Stream<List<Tarefa>>> listaDeTarefas() {
    return tarefaRepo.getTarefas().asStream(); // Assegura que retornamos um stream
  }

  createTarefa(Tarefa tarefa) async {
    await tarefaRepo.createTarefa(tarefa);
  }
}
