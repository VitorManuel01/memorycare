class Cuidadores {
  final String? id;
  final String nome;
  final int idade;
  final String parentescoFuncao;
  final String? email;
  final String telefone;

  Cuidadores(
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
}
