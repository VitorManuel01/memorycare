import 'package:cloud_firestore/cloud_firestore.dart';

class CuidadoresSecundarios {
  final String? id;
  final String nome;
  final int idade;
  final String parentescoFuncao;
  final String? email;
  final String telefone;

  CuidadoresSecundarios(
      {this.id,
      required this.nome,
      required this.idade,
      required this.parentescoFuncao,
      required this.email,
      required this.telefone});

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'idade': idade,
      'parentescoFuncao': parentescoFuncao,
      'email': email,
      'telefone': telefone,
    };
  }

    factory CuidadoresSecundarios.fromFirestore(DocumentSnapshot doc) {
    return CuidadoresSecundarios(
      id: doc.id, // Pega o ID do documento
      nome: doc['nome'],
      idade: doc['idade'],
      parentescoFuncao: doc['parentescoFuncao'],
      email: doc['email'],
      telefone: doc['telefone'],
    );
  }
}
