import 'package:cloud_firestore/cloud_firestore.dart';

class Area {
  final String? id;
  final String nome;
  final GeoPoint centro;
  final double raio;

  Area(
      {this.id,
      required this.nome,
      required this.centro,
      required this.raio});

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'centro': centro,
      'raio': raio,
    };
  }

  factory Area.fromFirestore(DocumentSnapshot doc) {
    return Area(
      id: doc.id, // Pega o ID do documento
      nome: doc['nome'],
      centro: doc['centro'],
      raio: doc['raio'],
    );
  }
}
