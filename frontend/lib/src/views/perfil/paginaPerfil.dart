import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class PaginaPerfil extends StatelessWidget {
  const PaginaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: const Icon(LineAwesomeIcons.angle_left_solid)),
        title: Text("Perfil", style: Theme.of(context).textTheme.headlineLarge,),
      ),
      body: Container(

      ),
    );
  }
}