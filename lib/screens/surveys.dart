import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_ana/globals.dart';
import 'dart:convert';
import 'package:share_plus/share_plus.dart';

class TelaVerLevantamentos extends StatefulWidget {
  @override
  _TelaVerLevantamentosState createState() => _TelaVerLevantamentosState();
}

class _TelaVerLevantamentosState extends State<TelaVerLevantamentos> {
  List<dynamic> levantamentos = [];

  @override
  void initState() {
    super.initState();
    _loadSurveys();
  }

  Future<void> _loadSurveys() async {
    final dir = await getExternalStorageDirectory();
    final surveysPath = '${dir?.path}/project_ana/files/';
    final directory = Directory(surveysPath);
    final files = directory.listSync();

    List<dynamic> loadedSurveys = [];
    for (var file in files) {
      if (file.path.endsWith('.json')) {
        final String contents = await File(file.path).readAsString();
        final dynamic surveyData = jsonDecode(contents);
        loadedSurveys.add(surveyData);
      }
    }

    setState(() {
      levantamentos = loadedSurveys;
    });
  }

  // Função para remover o levantamento
  Future<void> _removeSurvey(String surveyName, int index) async {
    final dir = await getExternalStorageDirectory();
    final surveysPath = '${dir?.path}/project_ana/files/';

    // Remove o arquivo JSON
    final File jsonFile = File('$surveysPath$surveyName.json');
    if (await jsonFile.exists()) {
      await jsonFile.delete();
    }

    // Remove o arquivo ZIP
    final File zipFile = File('$surveysPath$surveyName.zip');
    if (await zipFile.exists()) {
      await zipFile.delete();
    }

    // Atualiza a lista de levantamentos na tela
    setState(() {
      levantamentos.removeAt(index);
    });
  }

// Diálogo de confirmação para remoção
  void _confirmRemoveSurvey(String surveyName, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remover Levantamento'),
          content: Text('Você tem certeza que deseja apagar esse levantamento?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Remover'),
              onPressed: () {
                _removeSurvey(surveyName, index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AnaColors.back,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AnaColors.champagne, // Define a cor do ícone do botão de retornar
        ),
        title: Text('Levantamentos Feitos',
          style: TextStyle(color: AnaColors.desertSand),),
      ),
      body: ListView.builder(
        itemCount: levantamentos.length,
        itemBuilder: (context, index) {
          final survey = levantamentos[index];
          return Card(
            color: AnaColors.front,
            child: ListTile(
              title: Text(survey['name'],
                style: TextStyle(color: AnaColors.champagne),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min, // Adicionado para limitar o espaço da Row
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.share, color: AnaColors.champagne,),
                    onPressed: () => _shareSurvey(survey['zipPath']),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: AnaColors.champagne,),
                    onPressed: () => _confirmRemoveSurvey(survey['name'], index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


  void _shareSurvey(String zipPath) async {
    final File zipFile = File(zipPath);
    if (await zipFile.exists()) {
      Share.shareFiles([zipPath], text: 'Aqui está o levantamento.');
    } else {
      // Exiba um alerta ou mensagem indicando que o arquivo não foi encontrado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Arquivo ZIP não encontrado.')),
      );
    }
  }
}
