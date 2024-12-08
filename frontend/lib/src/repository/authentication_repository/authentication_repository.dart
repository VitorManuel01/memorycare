import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/repository/analise_preditiva/analise_preditiva_repository.dart';
import 'package:memorycare/src/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:memorycare/src/views/analise_preditiva/paginaTransicao.dart';
import 'package:memorycare/src/views/home/HomePage.dart';
import 'package:memorycare/src/views/registro/SignUpPageComplimentary.dart';
import 'package:memorycare/src/views/home/welcomePage.dart';
import 'package:memorycare/src/repository/authentication_repository/cuidador_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  CuidadorRepository cuidadoresRepo = Get.put(CuidadorRepository());
  AnalisePreditivaRepository analiseRepo =
      Get.put(AnalisePreditivaRepository());

  //Variaveis
  final _auth = FirebaseAuth.instance;
  late Rx<User?> firebaseUser;
  var verificationId = "".obs;
  var isManualRedirect = false.obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, (user) {
      if (!isManualRedirect.value) {
        _setInitialScreen(user);
      }
    });
  }

  // bool temCuidador() async{
  //   Cuidadores cuidador = zzzzzcuidadoresController.getCuidador(_auth.currentUser!.uid.toString());
  //   if()
  //   return true;
  // }

  Future<void> _setInitialScreen(User? user) async {
    if (user == null) {
      // Se o usuário não estiver autenticado
      Get.offAll(() => const WelcomePage());
    } else {
      try {
        // Verifica se o usuário tem cuidador
        final possuiCuidador = await cuidadoresRepo.hasCuidador();
        final existeDoc = await analiseRepo.verificarDocumentoExistente();
        final status = await analiseRepo.verificarStatusTeste();
        if (possuiCuidador) {
          if (existeDoc && status) {
            Get.offAll(() => const HomePage());
          } else {
            Get.offAll(() => const PaginaTransicaoAnalise());
          }
        } else {
          Get.offAll(() => const SignUpPageComplimentary());
        }
      } catch (e) {
        print("Erro ao determinar redirecionamento: $e");
        return;
      }
    }
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
    isManualRedirect.value = true;
    try {
      // Impede o redirecionamento automático
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Redireciona manualmente para a página complementar
      await Future.delayed(const Duration(
          milliseconds: 200)); // Pequeno atraso para evitar conflitos
      Get.offAll(() => const SignUpPageComplimentary());
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      print("FIREBASE AUTH EXCEPTION - ${ex.message}");
    } catch (_) {
      const ex = SignupEmailPasswordFailure();
      print("EXCEPTION - ${ex.message}");
      throw ex;
    } finally {
      isManualRedirect.value =
          false; // Reativa o redirecionamento automático após o fluxo manual
    }
  }

  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      // Tenta fazer o login com email e senha
      //UserCredential userCredential =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.to(() => const HomePage());
      // Obtém o token JWT
      // String? token = await userCredential.user?.getIdToken();

      // Envia o token para o backend para controle de sessão
      // if (token != null) {
      //   await sendTokenToBackend(token);
      // }
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

  // Future<void> sendTokenToBackend(String token) async {
  //   final response = await http.post(
  //     Uri.parse('http://10.0.2.2:3000/login'),
  //     headers: {'Authorization': 'Bearer $token'},
  //   );

  //   if (response.statusCode == 200) {
  //     print("Autenticado no backend");
  //   } else {
  //     print("Erro ao autenticar no backend: ${response.body}");
  //   }

  // }
  Future<void> logout() async {
    try {
      // Verifique se há streams ativos e encerre antes do logout
      await FirebaseAuth.instance.signOut();
      print('Usuário desconectado com sucesso.');
    } catch (e) {
      print('Erro ao desconectar: $e');
    }
  }
}
