import 'package:cloud_firestore/cloud_firestore.dart';

enum StatusTarefa {
  pendente,
  concluida,
}

class Tarefa {
  final String? id;
  final String idDependente;
  final String titulo;
  final Timestamp horario;
  final StatusTarefa status;
  final bool tarefaSeRepete;
  final Timestamp criadoEm;

  Tarefa({
    this.id,
    required this.idDependente,
    required this.titulo,
    required this.horario,
    required this.status,
    required this.tarefaSeRepete,
    required this.criadoEm,
  });

  toJson() {
    return {
      "idDependente": idDependente,
      "Titulo": titulo,
      "Horario": horario,
      "Status": status.name,
      "TarefaSeRepete": tarefaSeRepete,
      "CriadoEm": criadoEm
    };
  }
}
