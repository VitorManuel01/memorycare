import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:memorycare/src/utils/themes/theme.dart';
//import 'package:memorycare/src/views/AddTaskPage.dart';
//import 'package:memorycare/src/views/HomePage.dart';
import 'package:memorycare/src/views/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';


/// A classe MyApp é um widget sem estado (stateless), ou seja, sua interface não muda após ser construída.
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Construtor da classe, usa a chave para garantir que o widget seja único.

  @override
  Widget build(BuildContext context) {
    // O método `build` é onde a interface do widget é definida.
    var mediaQuerry = MediaQuery.of(context);
    var brightness = mediaQuerry.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de debug no canto superior direito.
      theme: isDarkMode ? TAppTheme.darkTheme : TAppTheme.lightTheme, // Use o tema claro
      // theme: TAppTheme.darkTheme, // Ou use o tema escuro, se preferir
      home: const WelcomePage(), // Define `WelcomePage` como a tela principal do aplicativo.
      // routes: {
      //   // Define as rotas nomeadas para navegação entre páginas.
      //   '/add-task': (context) => const AddTaskPage(), // Rota para a página de adicionar tarefas.
      // },
    );
  }
}