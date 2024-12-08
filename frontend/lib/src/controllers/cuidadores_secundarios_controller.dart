import 'package:get/get.dart';
import 'package:memorycare/src/models/cuidadoresSucundarios.dart';
import 'package:memorycare/src/repository/dependente/cuidadorSecundario_repository.dart';
import 'package:rxdart/rxdart.dart';

class CuidadoresSecundariosController extends GetxController {
  static CuidadoresSecundariosController get instance => Get.find();

  final cuidSecRepo = Get.put(CuidadorSecundarioRepository());

  Future<Stream<List<CuidadoresSecundarios>>> listaDeCuidSecFuture() {
    return cuidSecRepo.getCuidadoresSecundarios();
  }

  Stream<List<CuidadoresSecundarios>> listaDeCuidSec() {
    return listaDeCuidSecFuture().asStream().flatMap((stream) => stream);
  }

  createCuidadorSecundario(CuidadoresSecundarios cuidadoresSecundarios) async {
    await cuidSecRepo.createCuidadorSecundadrio(cuidadoresSecundarios);
  }

  Future<CuidadoresSecundarios> getCuidadorSecundario(String idCuidSec) async {
    return await cuidSecRepo.getCuidadorSecundario(idCuidSec);
  }

  editarCuidadorSecundario(CuidadoresSecundarios cuidadoresSecundarios, String idCuidSec) {
    cuidSecRepo.editarCuidadorSecundario(cuidadoresSecundarios, idCuidSec);
  }

  excluirCuidadorSecundario(String idCuidSec) {
    cuidSecRepo.excluirCuidadorSecundario(idCuidSec);
  }
}
