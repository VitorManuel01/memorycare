import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Form(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Nome Completo"),
              prefixIcon: Icon(Icons.person_outline_outlined)
            ,
          )),
          const SizedBox(height: 10.0,),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("E-Mail"),
              prefixIcon: Icon(Icons.email_outlined)
            ,
          )),
          const SizedBox(height: 10.0,),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Telefone"),
              prefixIcon: Icon(Icons.phone_android_outlined)
            ,
          )),
          const SizedBox(height: 10.0,),
          TextFormField(
            decoration: const InputDecoration(
              label: Text("Senha"),
              prefixIcon: Icon(Icons.lock_outline)
            ,
          )),
          const SizedBox(height: 10.0,),
    
          SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: (){}, child: const Text("REGISTRAR")))
        ],
      )),
    );
  }
}
