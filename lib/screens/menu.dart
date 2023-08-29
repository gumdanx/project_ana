// tela_principal.dart
import 'package:flutter/material.dart';
import 'package:project_ana/screens/new_survey.dart';
import 'package:project_ana/screens/surveys.dart';
import 'package:project_ana/screens/user.dart';

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Principal')),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Novo Levantamento'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaNovoLevantamento()),
              );
            },
          ),
          ListTile(
            title: Text('Levantamentos Feitos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaVerLevantamentos()),
              );
            },
          ),
          ListTile(
            title: Text('Usuário'),
            onTap: () {
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
