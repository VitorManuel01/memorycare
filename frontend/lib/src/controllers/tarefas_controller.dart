import 'package:get/get.dart';
import 'package:memorycare/src/models/tarefa.dart';
import 'package:memorycare/src/repository/dependente/tarefas_repository.dart';
import 'package:memorycare/src/services/notificationService.dart';
import 'package:rxdart/rxdart.dart';

class TarefasController extends GetxController {
  static TarefasController get instance => Get.find();

  final tarefaRepo = Get.put(TarefasRepository());

  Future<Stream<List<Tarefa>>> listaDeTarefasFuture() {
    return tarefaRepo.getTarefas();
  }

  Stream<List<Tarefa>> listaDeTarefas() {
    return listaDeTarefasFuture().asStream().flatMap((stream) => stream);
  }

  createTarefa(Tarefa tarefa) async {
    await tarefaRepo.createTarefa(tarefa);
  }

  Future<Tarefa> getTarefa(String idTarefa) async {
    return await tarefaRepo.getTarefa(idTarefa);
  }

  editarTarefa(Tarefa tarefa, String idTarefa) {
    tarefaRepo.editarTarefa(tarefa, idTarefa);
  }

  excluirTarefa(String idTarefa) {
    tarefaRepo.excluirTarefa(idTarefa);
  }
}
