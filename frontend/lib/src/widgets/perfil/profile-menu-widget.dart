import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileMenuWidget extends StatelessWidget {
    final String titulo;
    final IconData icone;
    final VoidCallback onPress;
    final bool endIcon;
    final Color? corDoTexto;
    
  const ProfileMenuWidget({
    super.key,
    required this.titulo, 
    required this.icone, 
    required this.onPress, 
    this.endIcon = true, 
    this.corDoTexto, 
  });
  
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    final iconColor = isDarkMode ? Colors.yellow : const Color(0xff001bff);

    return ListTile(
      onTap: onPress,
      leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: iconColor.withOpacity(0.1)),
          child: Icon(
            icone,
            color: iconColor,
          )),
      title: Text(
        titulo,
        style: Theme.of(context).textTheme.bodySmall?.apply(color: corDoTexto),
      ),
      trailing: endIcon? Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.grey.withOpacity(0.1)),
          child: const Icon(
            LineAwesomeIcons.angle_right_solid,
            size: 18,
            color: Colors.grey,
          ),
          ): null,
    );
  }
}
