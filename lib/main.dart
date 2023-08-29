// main.dart
import 'package:flutter/material.dart';
import 'package:project_ana/screens/login.dart'; // Certifique-se de que o caminho de importação esteja correto!

void main() => runApp(MeuAplicativo());

class MeuAplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nome do Aplicativo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaLogin(),
    );
  }
}
