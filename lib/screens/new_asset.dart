import 'package:flutter/material.dart';
import 'package:project_ana/screens/asset_data.dart';
import 'package:project_ana/globals.dart';
// Certifique-se de importar a tela TelaTipoAsset quando você a criar
// import 'tela_tipo_asset.dart';

class TelaNovoAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Asset',
        style: TextStyle(color: AnaColors.desertSand),)),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Tipo Asset 1',
              style: TextStyle(color: AnaColors.champagne),),
            onTap: () {
              // Navegue para a tela TelaTipoAsset
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TelaTipoAsset(tipo: 'Tipo Asset 1')));
            },
          ),
          ListTile(
            title: Text('Tipo Asset 2',
              style: TextStyle(color: AnaColors.desertSand),),
            onTap: () {
              // Navegue para a tela TelaTipoAsset
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TelaTipoAsset(tipo: 'Tipo Asset 2')));
            },
          ),
          // Repita para outros tipos de assets...
        ],
      ),
    );
  }
}
