
import 'package:flutter/material.dart';

class HeaderFormWidget extends StatelessWidget {
  const HeaderFormWidget(
      {super.key,
      required this.imagem,
      required this.titulo,
      required this.subtitulo,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.heightBetween,  
      this.imageHeight = 0.2, 
      this.textAlign});

  final String imagem, titulo, subtitulo;
  final CrossAxisAlignment crossAxisAlignment;
  final double? heightBetween;
  final double imageHeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Image(
          image: AssetImage(imagem),
          height: size.height * imageHeight,
        ),
        SizedBox(
          height: heightBetween,
        ),
        Text(
          titulo,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          subtitulo,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
