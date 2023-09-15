// main.dart
import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:project_ana/screens/login.dart'; // ATENCAO A ESSE IMPORT

void main() => runApp(MeuAplicativo());



class MeuAplicativo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'project ANA',
      theme: ThemeData(
        primarySwatch: AnaColors.back,
        scaffoldBackgroundColor: AnaColors.back,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaLogin(),
    );
  }
}
