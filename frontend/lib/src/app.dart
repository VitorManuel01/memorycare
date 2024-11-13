import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memorycare/src/utils/themes/theme.dart';
import 'package:memorycare/src/views/HomePage.dart';
//import 'package:memorycare/src/views/AddTaskPage.dart';
//import 'package:memorycare/src/views/HomePage.dart';



/// A classe MemoryCareApp é um widget sem estado (stateless), ou seja, sua interface não muda após ser construída.
class MemoryCareApp extends StatelessWidget {
  const MemoryCareApp({super.key}); // Construtor da classe, usa a chave para garantir que o widget seja único.

  @override
  Widget build(BuildContext context) {
    // O método `build` é onde a interface do widget é definida.
    var mediaQuerry = MediaQuery.of(context);
    var brightness = mediaQuerry.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de debug no canto superior direito.
      theme: isDarkMode ? TAppTheme.darkTheme : TAppTheme.lightTheme, // Use o tema claro
      home: const HomePage(),
      //const CircularProgressIndicator()
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      // routes: {
      //   // Define as rotas nomeadas para navegação entre páginas.
      //   '/add-task': (context) => const AddTaskPage(), // Rota para a página de adicionar tarefas.
      // },
    );
  }
}