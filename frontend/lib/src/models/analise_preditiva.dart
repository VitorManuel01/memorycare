import 'package:cloud_firestore/cloud_firestore.dart';

class AnalisePreditiva {
  String id;
  String semana;
  bool status;
  Timestamp? dataConclusao;
  int pontuacaoTotal;
  String resultado;

  AnalisePreditiva({
    required this.id,
    required this.semana,
    required this.status,
    required this.dataConclusao,
    required this.pontuacaoTotal,
    required this.resultado,
  });

  // Método para converter diretamente sem usar toJson nas classes filhas
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'semana': semana,
      'status': status,
      'dataConclusao': dataConclusao,
      'pontuacaoTotal': pontuacaoTotal,
      'resultado': resultado,
    };
  }

  // Método para converter um objeto AnalisePreditiva a partir de um Map (usado para recuperar dados do Firestore)
  factory AnalisePreditiva.fromJson(Map<String, dynamic> json) {
    return AnalisePreditiva(
      id: json['id'],
      semana: json['semana'],
      status: json['status'],
      dataConclusao: json['dataConclusao'] ?? Timestamp.now(),
      pontuacaoTotal: json['pontuacaoTotal'],
      resultado: json['resultado'],
    );
  }

  // Método para converter DocumentSnapshot do Firestore em um objeto AnalisePreditiva
  factory AnalisePreditiva.fromFirestore(DocumentSnapshot doc) {
    return AnalisePreditiva(
      id: doc.id, // Pega o ID do documento
      semana: doc['semana'], // Converte o Timestamp para DateTime
      status: doc['status'],
      dataConclusao: doc['dataConclusao'], // Firestore retorna um Timestamp
      pontuacaoTotal: doc['pontuacaoTotal'],
      resultado: doc['resultado'],
    );
  }
}
