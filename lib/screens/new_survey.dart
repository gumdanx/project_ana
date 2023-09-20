import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:project_ana/screens/new_asset.dart';
import 'package:project_ana/screens/assets.dart';



class TelaNovoLevantamento extends StatefulWidget {
  @override
  _TelaNovoLevantamentoState createState() => _TelaNovoLevantamentoState();
}

class _TelaNovoLevantamentoState extends State<TelaNovoLevantamento> {
  String _surveyName = "Nome da Unidade 📝️";
  Color taEditado = AnaColors.champagne;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Levantamento',
          style: TextStyle(color: AnaColors.desertSand),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Container(
                  width: 280.0,
                  height: 60,
                  child: OutlinedButton(
                    child: Text(
                      _surveyName,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: taEditado,
                      onSurface: taEditado,
                      side: BorderSide(color: taEditado, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      _showDialog(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                  width: 280.0,
                  height: 60,
                  child: OutlinedButton(
                    child: Text(
                      'Novo Asset',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: AnaColors.champagne,
                      onSurface: AnaColors.champagne,
                      side: BorderSide(color: AnaColors.champagne, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaNovoAsset()),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                  width: 280.0,
                  height: 60,
                  child: OutlinedButton(
                    child: Text(
                      'Ver Assets',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: AnaColors.champagne,
                      onSurface: AnaColors.champagne,
                      side: BorderSide(color: AnaColors.champagne, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaVerAssets()),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                child: Container(
                  width: 280.0,
                  height: 60,
                  child: OutlinedButton(
                    child: Text(
                      'Salvar',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: AnaColors.champagne,
                      onSurface: AnaColors.champagne,
                      side: BorderSide(color: AnaColors.champagne, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Logic to save data
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Definir Nome da Pesquisa'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Insira o nome aqui"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _surveyName = _controller.text.isEmpty ? "Nome da Unidade 📝️" : _controller.text;
                  taEditado = _surveyName == "Nome da Unidade 📝️" ? AnaColors.champagne : AnaColors.front;
                });
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}