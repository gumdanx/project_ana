import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:project_ana/screens/new_asset.dart';
import 'package:project_ana/screens/assets.dart';

class TelaNovoLevantamento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Levantamento')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,  // Alterado para preencher a largura disponível
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome da área ou unidade',
              ),
            ),
            SizedBox(height: 10.0), // Adicionado para espaço entre os widgets
            OutlinedButton(
              child: Text('Novo Asset'),
              style: OutlinedButton.styleFrom(
                primary: AnaColors.darkBlue,
                onSurface: AnaColors.champagne,
                side: BorderSide(color: AnaColors.champagne, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaNovoAsset()),
                );
              },
            ),
            SizedBox(height: 10.0),
            OutlinedButton(
              child: Text('Ver Assets'),
              style: OutlinedButton.styleFrom(
                primary: AnaColors.darkBlue,
                onSurface: AnaColors.champagne,
                side: BorderSide(color: AnaColors.champagne, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaVerAssets()),
                );
              },
            ),
            SizedBox(height: 10.0),
            OutlinedButton(
              child: Text('Salvar'),
              style: OutlinedButton.styleFrom(
                primary: AnaColors.darkBlue,
                onSurface: AnaColors.champagne,
                side: BorderSide(color: AnaColors.champagne, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                // Logic to save data
              },
            ),
          ],
        ),
      ),
    );
  }
}

