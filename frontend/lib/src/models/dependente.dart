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
}
