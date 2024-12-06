import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/repository/analise_preditiva/analise_preditiva_repository.dart';

class AnalisePreditivaController extends GetxController {
  var pontuacaoTotal = 0.obs;
  var resultado = "".obs;
  var indiceDominio = 0.obs;

  final analiseRepo = Get.put(AnalisePreditivaRepository());

  @override
  void onInit() {
    super.onInit();
    iniciarAnalise(); // Chama a função de inicialização quando o controlador for carregado
  }

  // Avança para o próximo domínio
  void proximoDominio() {
    indiceDominio.value++;
  }

  // Determina o resultado com base na pontuação final
  void determinarResultado() {
    if (pontuacaoTotal.value >= 24) {
      resultado.value = "Cognitivo normal";
    } else if (pontuacaoTotal.value >= 18) {
      resultado.value = "Comprometimento cognitivo leve";
    } else {
      resultado.value = "Comprometimento cognitivo moderado a grave";
    }
  }

  // Adiciona pontos à pontuação total
  void adicionarPontos(int pontos) {
    pontuacaoTotal.value += pontos;
  }

  // Reinicia o questionário
  void resetar() {
    pontuacaoTotal.value = 0;
    resultado.value = '';
    indiceDominio.value = 0;
  }

  Future<bool> verificarStatusTeste() {
    return analiseRepo.verificarStatusTeste();
  }

  Future<bool> verificarSeExisteDoc() async {
    bool existeDocumento = await analiseRepo.verificarDocumentoExistente();
    return existeDocumento;
  }

  Future<void> iniciarAnalise() async {
    // Verifica se já existe um documento para a semana atual
    bool existeDocumento = await analiseRepo.verificarDocumentoExistente();

    if (existeDocumento) {
      return; // Não cria um novo documento se já existir
    }

    // Se não existir, cria um novo documento de análise
    await analiseRepo.salvarInicioTeste();
  }

  Future<void> salvarResultados(int pontos, String resultado) async {
    await analiseRepo.salvarResultadoTeste(pontos, resultado);
  }
}
