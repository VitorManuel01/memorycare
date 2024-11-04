import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:memorycare/src/views/HomePage.dart';
import 'package:memorycare/src/views/welcomePage.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variaveis
  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  var verificationId = "".obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomePage())
        : Get.offAll(() => const HomePage());
  }

  Future<void> phoneNumberAuthentication(String telefone) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: telefone,
        verificationCompleted: (credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == "invalid-phone-number") {
            Get.snackbar("Erro", "Telefone fornecido não é válido.");
          } else {
            Get.snackbar("Erro", "Algo deu errado, tente novamente.");
          }
        },
        codeSent: (verificationId, resentToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        });
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));

    return credentials.user != null ? true : false;
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      firebaseUser.value != null
          ? Get.offAll(() => const HomePage())
          : Get.offAll(() => const WelcomePage());
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      // ignore: avoid_print
      print("FIREBASE AUTH EXCEPTION - ${ex.message}");
    } catch (_) {
      const ex = SignupEmailPasswordFailure();
      // ignore: avoid_print
      print("EXCEPTION - ${ex.message}");
      throw ex;
    }
  }

Future<void> loginUserWithEmailAndPassword(
    String email, String password) async {
  try {
    // Tenta fazer o login com email e senha
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    // Trata o erro retornando uma mensagem específica para cada código de erro
    String errorMessage;
    switch (e.code) {
      case 'invalid-email':
        errorMessage = 'O endereço de email é inválido.';
        break;
      case 'user-disabled':
        errorMessage = 'Esta conta foi desativada.';
        break;
      case 'user-not-found':
        errorMessage = 'Não há usuário com este email.';
        break;
      case 'wrong-password':
        errorMessage = 'A senha está incorreta.';
        break;
      default:
        errorMessage = 'Ocorreu um erro desconhecido.';
    }

    // Exibe a mensagem de erro, por exemplo, usando print ou snackbar
    print(errorMessage);
    // ou
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));

    // Opcional: retorna o erro para o chamador (ajuda no teste ou no controle do erro)
    return Future.error(errorMessage);
  }
}


  Future<void> logout() async => await _auth.signOut();
}
