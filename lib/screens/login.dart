// tela_login.dart
import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:project_ana/screens/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedUsername();
  }

  // Carregue o nome do usuário salvo
  void _loadSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('savedUsername');
    if (savedUsername != null) {
      setState(() {
        usernameController.text = savedUsername;
      });
    }
  }

  void _login() async {
    if (passwordController.text == 'yellowstone') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('savedUsername', usernameController.text);
      loggedInUsername = usernameController.text;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TelaPrincipal()),
      );
    } else {
      // Mostra uma mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Senha incorreta!')),
      );
    }
  }

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
                controller: usernameController,
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
                controller: passwordController,
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
                child: Text('Entrar', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  primary: AnaColors.front, // Define a cor de fundo do botão.
                  onPrimary: Colors.white, // Define a cor do texto do botão.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // 20dp corner radius
                  ),
                ),
                onPressed: _login,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
