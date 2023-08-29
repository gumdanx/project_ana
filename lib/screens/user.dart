// arquivo tela_usuario.dart

import 'package:flutter/material.dart';

class TelaUsuario extends StatefulWidget {
  @override
  _TelaUsuarioState createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Mudar Senha'),
              onPressed: _mostrarDialogoMudancaSenha,
            ),
            // Adicione mais opções se necessário.
          ],
        ),
      ),
    );
  }

  void _mostrarDialogoMudancaSenha() {
    final TextEditingController _senhaController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mudar Senha'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _senhaController,
                decoration: InputDecoration(labelText: 'Nova Senha'),
                obscureText: true,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: 'Confirme a Nova Senha'),
                obscureText: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Salvar'),
              onPressed: () {
                // Aqui, você pode adicionar a funcionalidade para atualizar a senha do usuário.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
