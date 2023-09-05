// tela_principal.dart
import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:project_ana/screens/new_survey.dart';
import 'package:project_ana/screens/surveys.dart';
import 'package:project_ana/screens/user.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('project ANA',
          style: TextStyle(color: AnaColors.desertSand)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0), // Add padding around the list view for better spacing
        children: <Widget>[
          OutlinedButton(
            child: Text('Novo Levantamento'),
            style: OutlinedButton.styleFrom(
              primary: AnaColors.champagne, // Text color
              onSurface: AnaColors.champagne, // Border color when button is enabled
              side: BorderSide(color: AnaColors.champagne, width: 1.5), // Customize border details
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaNovoLevantamento()),
              );
            },
          ),
          SizedBox(height: 10.0), // Add space between buttons
          OutlinedButton(
            child: Text('Levantamentos Feitos'),
            style: OutlinedButton.styleFrom(
            primary: AnaColors.champagne,
            onSurface: AnaColors.champagne,
            side: BorderSide(color: AnaColors.champagne, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaVerLevantamentos()),
              );
            },
          ),
          SizedBox(height: 10.0),
          OutlinedButton(
            child: Text('Usuário'),
            style: OutlinedButton.styleFrom(
              primary: AnaColors.champagne,
              onSurface: AnaColors.champagne,
              side: BorderSide(color: AnaColors.champagne, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaUsuario()),
              );
            },
          ),
        ],
      ),
    );
  }
}
