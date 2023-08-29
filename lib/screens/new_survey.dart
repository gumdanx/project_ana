import 'package:flutter/material.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome da área ou unidade',
              ),
            ),
            ElevatedButton(
              child: Text('Novo Asset'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaNovoAsset()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Ver Assets'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaVerAssets()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Salvar'),
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
