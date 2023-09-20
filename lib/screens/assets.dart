import 'package:flutter/material.dart';
// Certifique-se de importar a tela de edição quando você a criar
// import 'tela_editar_asset.dart';
import 'package:project_ana/screens/edit_asset.dart';
import 'package:project_ana/globals.dart';

class TelaVerAssets extends StatefulWidget {
  @override
  _TelaVerAssetsState createState() => _TelaVerAssetsState();
}

class _TelaVerAssetsState extends State<TelaVerAssets> {
  // Lista de exemplo. Em uma aplicação real, esses dados provavelmente viriam de um banco de dados.
  final List<String> assets = ["Asset 1", "Asset 2", "Asset 3", "Asset 4"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ver Assets',
        style: TextStyle(color: AnaColors.desertSand),)),
      body: ListView.builder(
        itemCount: assets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(assets[index],
              style: TextStyle(color: AnaColors.front),),
            onTap: () {
              // Navegue para a tela de edição
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TelaEditarAsset(nome: assets[index])));
            },
          );
        },
      ),
    );
  }
}
