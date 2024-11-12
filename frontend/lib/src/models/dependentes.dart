class Dependentes {
  final String? id;
  final String nome;
  final int idade;
  final String contatoEmergencia;
  final String endereco;
  final String telefone;
  final String cuidadorPrincipal;

  Dependentes( {
      this.id,
      required this.nome,
      required this.idade,
      required this.contatoEmergencia,
      required this.endereco,
      required this.telefone,
      required this.cuidadorPrincipal,
      });

        toJson() {
    return {
      "NomeCompleto": nome,
      "Idade": idade,
      "ContatoEmergencia": contatoEmergencia,
      "Residencia": endereco,
      "Telefone": telefone,      
      "CuidadorPrincipal": cuidadorPrincipal
    };
    
  }
}
