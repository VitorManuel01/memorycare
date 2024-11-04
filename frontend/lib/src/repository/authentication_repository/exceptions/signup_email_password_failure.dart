class SignupEmailPasswordFailure {
  final String message;
  const SignupEmailPasswordFailure(
      [this.message = "Ocorreu um erro inesperado"]);
  factory SignupEmailPasswordFailure.code(String code) {
    switch (code) {
      case "weak-password":
        return const SignupEmailPasswordFailure(
            "Por Favor, insira um senha mais forte.");
      case "invalid-email":
        return const SignupEmailPasswordFailure(
            "Este E-Mail não é válido ou está mal formatado.");
      case "email-already-in-use":
        return const SignupEmailPasswordFailure(
            "Uma conta com este E-Mail já existe.");
      case "operation-not-allowed":
        return const SignupEmailPasswordFailure(
            "Operação não permitida, por favor entre em contato com suporte.");
      case "user-disabled":
        return const SignupEmailPasswordFailure(
            "Este usuário foi desabilitado, por favor entre em contato com suporte.");
      default:
        return const SignupEmailPasswordFailure();
    }
  }
}
