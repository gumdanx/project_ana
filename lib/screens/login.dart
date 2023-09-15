// tela_login.dart
import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:project_ana/screens/menu.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AnaColors.back,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('project ANA',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AnaColors.front,
                )),
            SizedBox(height: 20),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300), // Define a largura máxima
              child: TextField(
                style: TextStyle(color: AnaColors.front),
                decoration: InputDecoration(
                  labelText: 'Nome de usuário',
                  labelStyle: TextStyle(color: AnaColors.front),
                  hintText: 'ex.: richard@lacos21.com',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
              ),
            ),
            SizedBox(height: 10),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 300), // Define a largura máxima
              child: TextField(
                style: TextStyle(color: AnaColors.front),
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: AnaColors.front),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 120, // Ajuste a largura conforme necessário
              height: 50,
              child: ElevatedButton(
                child: Text('Entrar',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: AnaColors.front, // Define a cor de fundo do botão.
                  onPrimary: Colors.white, // Define a cor do texto do botão.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // 20dp corner radius
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TelaPrincipal()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
