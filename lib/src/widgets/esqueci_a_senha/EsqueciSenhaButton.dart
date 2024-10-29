import 'package:flutter/material.dart';

class EsqueciSenhaButton extends StatelessWidget {
  const EsqueciSenhaButton(
      {super.key,
      required this.onTap,
      required this.titulo,
      required this.subtitulo,
      required this.icone});

  final String titulo, subtitulo;
  final IconData icone;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey),
        child: Row(
          children: [
            Icon(
              icone,
              size: 60,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(subtitulo, style: Theme.of(context).textTheme.bodyMedium)
              ],
            )
          ],
        ),
      ),
    );
  }
}
