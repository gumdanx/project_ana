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
      backgroundColor: AnaColors.back, // Define a cor de fundo do Scaffold
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'project ANA',
          style: TextStyle(color: AnaColors.desertSand),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(
            16.0), // Add padding around the list view for better spacing
        children: <Widget>[
          Center(
            // Centraliza o Container
            child: Container(
              width: 280.0, // Define uma largura fixa para o Container
              height: 60,
              child: OutlinedButton(
                child: Text(
                  'Novo Levantamento',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  primary: AnaColors.champagne, // Text color
                  onSurface: AnaColors
                      .champagne, // Border color when button is enabled
                  side: BorderSide(
                      color: AnaColors.champagne,
                      width: 1.5), // Customize border details
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaNovoLevantamento()),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 30.0), // Add space between buttons
          Center(
            child: Container(
              width: 280.0, // Define uma largura fixa para o Container
              height: 60,
              child: OutlinedButton(
                child: Text('Levantamentos Feitos',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  primary: AnaColors.champagne,
                  onSurface: AnaColors.champagne,
                  side: BorderSide(color: AnaColors.champagne, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaVerLevantamentos()),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 30.0),
          Center(
            child: Container(
              width: 280.0, // Define uma largura fixa para o Container
              height: 60,
              child: OutlinedButton(
                child: Text('Usuário',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  primary: AnaColors.champagne,
                  onSurface: AnaColors.champagne,
                  side: BorderSide(color: AnaColors.champagne, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaUsuario()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
