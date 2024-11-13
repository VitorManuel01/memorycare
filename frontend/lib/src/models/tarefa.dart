import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memorycare/src/models/StatusTarefa.dart';

class Tarefa {
  final String? id;
  final String titulo;
  final Timestamp diaEhorario;
  final StatusTarefa status;
  final bool tarefaSeRepete;
  final Timestamp criadoEm;

  Tarefa({
    this.id,
    required this.titulo,
    required this.diaEhorario,
    required this.status,
    required this.tarefaSeRepete,
    required this.criadoEm,
  });

  toJson() {
    return {
      "Titulo": titulo,
      "DataEHora": diaEhorario,
      "Status": status.name,
      "TarefaSeRepete": tarefaSeRepete,
      "CriadoEm": criadoEm
    };
  }
  static StatusTarefa statusFromString(String status) {
  return StatusTarefa.values.firstWhere(
    (e) => e.toString().split('.').last == status,
    orElse: () => StatusTarefa.pendente, // Valor padrão se não encontrar uma correspondência
  );
}

  factory Tarefa.fromFirestore(DocumentSnapshot doc) {
    return Tarefa(
      id: doc.id, // Pega o ID do documento
      titulo: doc['Titulo'],
      diaEhorario: doc['DataEHora'],
      status:  statusFromString(doc['Status']) ,
      tarefaSeRepete: doc['TarefaSeRepete'],
      criadoEm: doc['CriadoEm'],
    );
  }
}
