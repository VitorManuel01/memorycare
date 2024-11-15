import 'package:get/get.dart';
import 'package:memorycare/src/models/cuidadores.dart';
import 'package:memorycare/src/repository/authentication_repository/cuidador_repository.dart';

class CuidadoresController extends GetxController {
  static CuidadoresController get instance => Get.find();

  final cuidadorRepo = Get.put(CuidadorRepository());

  Future<Cuidadores> getCuidador(String uid) async {
    return await cuidadorRepo.getCuidador(uid);
  }

  // Future<bool> hasCuidador() {
  //   return cuidadorRepo.hasCuidador();
  // }
}
