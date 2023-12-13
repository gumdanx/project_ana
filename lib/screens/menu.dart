// tela_principal.dart
import 'package:flutter/material.dart';
import 'package:projeto_ana/globals.dart';
import 'package:projeto_ana/screens/new_survey.dart';
import 'package:projeto_ana/screens/surveys.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AnaColors.back,
      appBar: AppBar(
        backgroundColor: AnaColors.back,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              AnaColors.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: AnaColors.champagne,
            ),
            onPressed: () {
              AnaColors.isDarkMode = !AnaColors.isDarkMode;
              (context as Element).reassemble();
            },
          ),
        ],
        title: Text(
          'Projeto ANA',
          style: TextStyle(color: AnaColors.desertSand),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Botão "Novo Levantamento"
            Center(
              child: Container(
                width: 280.0,
                height: 60,
                margin: EdgeInsets.only(top: 30.0),
                child: OutlinedButton(
                  child: Text(
                    'Novo Levantamento',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: AnaColors.champagne,
                    side: BorderSide(color: AnaColors.champagne, width: 1.5),
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
            // Espaço entre os botões
            SizedBox(height: 30.0),
            // Botão "Levantamentos Feitos"
            Center(
              child: Container(
                width: 280.0,
                height: 60,
                child: OutlinedButton(
                  child: Text(
                    'Levantamentos Feitos',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: OutlinedButton.styleFrom(
                    primary: AnaColors.champagne,
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
            // Espaço antes da imagem
            SizedBox(height: 30.0),
            // Imagem
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Image.asset(
                biglogo,
                width: 500, // Ajuste conforme necessário
                height: 500, // Ajuste conforme necessário
              ),
            ),
          ],
        ),
      ),
    );
  }
}