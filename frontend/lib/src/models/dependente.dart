import 'package:cloud_firestore/cloud_firestore.dart';

class Dependente {
  final String? id;
  final String nome;
  final int idade;
  final String contatoEmergencia;
  final String telefone;
  final String endereco;
  final String cuidadorPrincipal;

  Dependente({
    this.id,
    required this.nome,
    required this.idade,
    required this.contatoEmergencia,
    required this.telefone,
    required this.endereco,
    required this.cuidadorPrincipal,
  });

  Map<String, dynamic> toJson() {
    return {
      "NomeCompleto": nome,
      "Idade": idade,
      "ContatoEmergencia": contatoEmergencia,
      "Telefone": telefone,
      "Residencia": endereco,
      "CuidadorPrincipal": cuidadorPrincipal
    };
  }

    factory Dependente.fromFirestore(DocumentSnapshot doc) {
    return Dependente(
      id: doc.id, // Pega o ID do documento
      nome: doc['NomeCompleto'],
      idade: doc['Idade'],
      contatoEmergencia: doc['ContatoEmergencia'],
      telefone: doc['Telefone'],
      endereco: doc['Residencia'],
      cuidadorPrincipal: doc['CuidadorPrincipal'],
    );
  }
}
