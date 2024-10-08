import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Center(
        child: Text(
          "Olá Mundo",
          style: TextStyle(
              fontSize: 50, backgroundColor: Colors.white, color: Colors.black),
        ),
      ),
    ),
  );
}
