import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/models/analise_preditiva.dart';

class AnalisePreditivaRepository extends GetxController {
  static AnalisePreditivaRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String?> obterUidUsuario() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    } else {
      return null;
    }
  }

  Future<String?> obterIdDependente(String uidCuidador) async {
    // Busca o primeiro dependente do cuidador
    QuerySnapshot dependenteSnapshot = await _db
        .collection("cuidadores")
        .doc(uidCuidador)
        .collection("dependente")
        .get();

    if (dependenteSnapshot.docs.isNotEmpty) {
      // Retorna o ID do primeiro documento na coleção `dependente`
      return dependenteSnapshot.docs.first.id;
    } else {
      return null;
    }
  }

  String gerarIdSemana() {
    DateTime hoje = DateTime.now();
    // Calcula o número da semana (semana do ano)
    int numeroDaSemana =
        (hoje.difference(DateTime(hoje.year, 1, 1)).inDays / 7).floor() + 1;
    String semanaId = '${hoje.year}-W$numeroDaSemana';

    // Cria o ID com o formato "ano-semana"
    return semanaId;
  }

  int pegarNumeroDaSemana() {
    DateTime hoje = DateTime.now();
    int numeroDaSemana =
        (hoje.difference(DateTime(hoje.year, 1, 1)).inDays / 7).floor() + 1;
    return numeroDaSemana;
  }

  Future<void> salvarInicioTeste() async {
    String? uid = await obterUidUsuario();

    // Verifica se o usuário está autenticado
    if (uid == null) {
      Get.snackbar(
        "Erro",
        "Usuário não autenticado.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return; // Retorna para não tentar salvar o dependente
    }

    String? idDependente = await obterIdDependente(uid);
    if (idDependente == null) {
      throw Exception("Dependente não encontrado para o cuidador");
    }

    await _db
        .collection(
            'cuidadores/$uid/dependente/$idDependente/analise_preditiva')
        .doc(gerarIdSemana()) // Usa a semana como o id do documento
        .set(
      {
        'semana': pegarNumeroDaSemana().toString(),
        'status':
            false, // Status = false significa que o teste ainda não foi feito
        'dataConclusao': null, // Nenhuma data de conclusão ainda
        'pontuacaoTotal': 0, // Nenhuma pontuação ainda
        'resultado': '', // Nenhum resultado ainda
      },
      SetOptions(
          merge: true), // Merge para não sobrescrever outros dados existentes
    ); // Merge para não sobrescrever outros dados existentes
  }

  Future<void> salvarResultadoTeste( int pontuacaoTotal, String resultado) async {
    String? uid = await obterUidUsuario();

    // Cria uma instância de AnalisePreditiva
    AnalisePreditiva analisePreditiva = AnalisePreditiva(
      id: gerarIdSemana(), // ID = semana (usando a data da semana como ID do documento)
      semana: pegarNumeroDaSemana().toString(),
      status: true, // O status agora é 'feito' (true)
      dataConclusao: Timestamp.now(), // Data de conclusão é a data atual
      pontuacaoTotal: pontuacaoTotal, // A pontuação que foi calculada
      resultado: resultado, // O resultado do teste
    );

    // Atualiza o documento com os dados completos
    if (uid == null) {
      Get.snackbar(
        "Erro",
        "Usuário não autenticado.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
      return; // Retorna para não tentar salvar o dependente
    }

    String? idDependente = await obterIdDependente(uid);
    if (idDependente == null) {
      throw Exception("Dependente não encontrado para o cuidador");
    }
    await _db
        .collection(
            'cuidadores/$uid/dependente/$idDependente/analise_preditiva')
        .doc(gerarIdSemana())
        .set(
          analisePreditiva
              .toJson(), // Converte o objeto para Map<String, dynamic>
          SetOptions(
              merge: true), // Merge para não sobrescrever dados existentes
        );
  }

  Future<bool> verificarStatusTeste() async {
    String? uid = await obterUidUsuario();

    // Verifica se o usuário está autenticado
    if (uid == null) {
      Get.snackbar(
        "Erro",
        "Usuário não autenticado.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
    }

    String? idDependente = await obterIdDependente(uid!);
    if (idDependente == null) {
      throw Exception("Dependente não encontrado para o cuidador");
    }

    final doc = await _db
        .collection(
            'cuidadores/$uid/dependente/$idDependente/analise_preditiva')
        .doc(gerarIdSemana())
        .get();

    if (doc.exists) {
      return doc['status'] == true; // Retorna true se o teste foi feito
    } else {
      return false; // Retorna false se não tiver registro para a semana
    }
  }

  Future<bool> verificarDocumentoExistente() async {
  String? uid = await obterUidUsuario();

  // Verifica se o usuário está autenticado
  if (uid == null) {
    return false;
  }

  String? idDependente = await obterIdDependente(uid);
  if (idDependente == null) {
    throw Exception("Dependente não encontrado para o cuidador");
  }

  // Obtém o ID da semana atual
  String semanaId = gerarIdSemana();

  // Verifica se o documento já existe no Firestore
  final doc = await _db
      .collection('cuidadores/$uid/dependente/$idDependente/analise_preditiva')
      .doc(semanaId)
      .get();

  // Retorna true se o documento já existe
  return doc.exists;
}
}
