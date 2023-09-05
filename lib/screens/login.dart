// tela_login.dart
import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:project_ana/screens/menu.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AnaColors.champagne,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('project ANA',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AnaColors.darkCyan,
                )),
            SizedBox(height: 20),
            TextField(
              style: TextStyle(color: AnaColors.darkBlue),
              decoration: InputDecoration(
                  labelText: 'Nome de usuário',
                  labelStyle: TextStyle(color: AnaColors.darkBlue),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              style: TextStyle(color: AnaColors.darkBlue),
              decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: AnaColors.darkBlue),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Entrar'),
              style: ElevatedButton.styleFrom(
                primary: AnaColors.darkBlue, // Define a cor de fundo do botão.
                onPrimary: AnaColors.champagne, // Define a cor do texto do botão.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // 20dp corner radius
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => TelaPrincipal()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
