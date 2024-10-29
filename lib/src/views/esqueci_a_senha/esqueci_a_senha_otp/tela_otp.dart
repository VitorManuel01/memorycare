import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';


class TelaOTP extends StatelessWidget {
  const TelaOTP({super.key});

  @override
  Widget build(BuildContext context) {
        var mediaQuerry = MediaQuery.of(context);

    var brightness = mediaQuerry.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Verificação", style: GoogleFonts.dynaPuff(
              fontWeight: FontWeight.bold,
              fontSize: 50
            ),),
            const SizedBox(height: 40,),
            const Text("Digite o código de verificação enviado em " "email@exemplo.com",textAlign: TextAlign.center,),
            const SizedBox(height: 20,),
            OtpTextField(
              numberOfFields: 6,
              fillColor: isDarkMode ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
              filled: true,
              keyboardType: TextInputType.number,
              onSubmit: (code){print("OTP é este código => $code");},
            ),
            const SizedBox(height: 20,),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: const Text("Próximo")))
          ],
        ),
      ),
      );
  }
}