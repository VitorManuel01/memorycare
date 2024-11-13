import 'package:get/get.dart';
import 'package:memorycare/src/repository/authentication_repository/authentication_repository.dart';
import 'package:memorycare/src/views/home/HomePage.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void veriftOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const HomePage()) : Get.back();
  }
}
