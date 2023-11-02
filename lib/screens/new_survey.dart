import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:project_ana/screens/new_asset.dart';
import 'package:project_ana/screens/assets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';

class TelaNovoLevantamento extends StatefulWidget {
  @override
  _TelaNovoLevantamentoState createState() => _TelaNovoLevantamentoState();
}

class _TelaNovoLevantamentoState extends State<TelaNovoLevantamento> {
  bool _isSurveyNameSet = false;
  String _surveyName = "Selecionar Unidade";
  Color taEditado = AnaColors.champagne;

  Future<void> addSurveyToUnfinished(String surveyName) async {
    final directory = await getExternalStorageDirectory();
    final path = directory?.path;
    final file = File('$path/project_ana/unfinished_surveys.json');
    print("Teste: Entrei em addSurveyToUnfinished!");

    // Verifica se o arquivo existe, se não, cria um novo arquivo.
    if (!await file.exists()) {
      // Cria o arquivo com uma lista vazia se o arquivo não existir.
      await file.create(recursive: true);
      await file.writeAsString('[]');
      print("Teste: Criei o arquivo até agora vazio!");
    }

    // Lê o conteúdo atual do arquivo.
    final String contents = await file.readAsString();
    final List<dynamic> surveys = json.decode(contents);

    String surveyPath = '${directory?.path}/project_ana/files/$_surveyName/';
    Map<String, dynamic> newSurvey = {
      'id': UniqueKey().toString(),
      'name': surveyName,
      'surveyPath': surveyPath,
    };

    // Adiciona o novo levantamento à lista.
    surveys.add(newSurvey);

    // Escreve de volta para o arquivo.
    await file.writeAsString(json.encode(surveys));
  }

  Future<void> cancelSurvey(String surveyName) async {
    final dir = await getExternalStorageDirectory();
    final appSurveysPath = File('${dir?.path}/project_ana/unfinished_surveys.json');
    final surveyDirPath = '${dir?.path}/project_ana/files/$surveyName/';

    // Remove o levantamento do JSON
    if (await appSurveysPath.exists()) {
      final String content = await appSurveysPath.readAsString();
      List<dynamic> surveys = json.decode(content);
      surveys.removeWhere((survey) => survey['name'] == surveyName);
      await appSurveysPath.writeAsString(json.encode(surveys));
    }

    // Remove o diretório do levantamento
    final surveyDir = Directory(surveyDirPath);
    if (await surveyDir.exists()) {
      await surveyDir.delete(recursive: true);
    }
  }

  Future<List<File>> listDir(String folderPath) async {
    var dir = Directory(folderPath);
    List<File> files = [];

    if (await dir.exists()) {
      var completer = Completer<void>();
      List<FileSystemEntity> entries = [];

      var lister = dir.list(recursive: true);
      lister.listen(
            (entry) {
          if (entry is File) {
            entries.add(entry);
          }
        },
        onDone: () => completer.complete(),
      );

      await completer.future;
      files = entries.cast<File>();
    }

    return files;
  }

  void _onSavePressed() async {
    try {
      final dir = await getExternalStorageDirectory();
      final surveyPath = '${dir?.path}/project_ana/files/${_surveyName}/';

      // Lista todos os arquivos na pasta do levantamento e suas subpastas.
      List<File> files = await listDir(surveyPath);

      if (files.isEmpty) {
        throw Exception('Nenhum arquivo encontrado para compactar.');
      }

      // Chama a função para criar o arquivo ZIP e obtém o caminho.
      String zipPath = await createZip(files, _surveyName);

      // Salva as informações do levantamento no arquivo JSON.
      await saveSurveyInfo(_surveyName, zipPath);

      // Cancela o levantamento (apagar diretório e remover do JSON)
      cancelSurvey(_surveyName);

      // Retorna para a tela inicial
      Navigator.of(context).popUntil((route) => route.isFirst);

      // Mensagem de Sucesso
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Levantamento finalizado com sucesso'))
      );
    } catch (e) {
      // Se ocorrer um erro, mostre uma mensagem para o usuário.
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar o levantamento: $e'))
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AnaColors.champagne, // Define a cor do ícone do botão de retornar
        ),
        title: Text('Novo Levantamento',
          style: TextStyle(color: AnaColors.champagne),),
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
                    onPressed: _isSurveyNameSet ? null : () => _showDialog(context)
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
                      if (_surveyName == "Selecionar Unidade") {
                        // Se o nome da unidade não for definido, exiba uma mensagem de erro.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Por favor, defina o nome da unidade antes de adicionar um novo asset!'))
                        );
                        return;
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelaNovoAsset(surveyName: _surveyName,)
                          ),
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
                            builder: (context) => TelaVerAssets(surveyName: _surveyName),
                        )
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
                      'Finalizar',
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
                    onPressed: _onSavePressed,
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
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      primary: Colors.red,
                      onSurface: Colors.red,
                      side: BorderSide(color: Colors.red, width: 2.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Chama a função para cancelar o levantamento
                      cancelSurvey(_surveyName);
                      // Retorna para a tela anterior ou executa outra ação
                      Navigator.of(context).pop();
                    }
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
    if (_isSurveyNameSet) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('O nome do levantamento já foi definido e não pode ser alterado.')));
      return;
    }
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        // Use FutureBuilder<Directory?> para lidar com Directory nulo
        return FutureBuilder<Directory?>(
          future: getExternalStorageDirectory(),
          builder: (BuildContext context, AsyncSnapshot<Directory?> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                // Certifique-se de verificar se o snapshot.data não é nulo
                final directory = snapshot.data;
                if (directory != null) {
                  final appSurveysPath = File('${directory?.path}/project_ana/unfinished_surveys.json');
                  return FutureBuilder<String>(
                    future: appSurveysPath.readAsString(),
                    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                      List<dynamic> unfinishedSurveys = [];
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          unfinishedSurveys = json.decode(snapshot.data!);
                        }
                        return AlertDialog(
                          backgroundColor: AnaColors.back,
                          title: Text('Definir Nome da Pesquisa',
                          style: TextStyle(color: AnaColors.champagne),),
                          content: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: _controller,
                                  decoration: InputDecoration(
                                      hintText: "Novo? Insira o nome aqui",
                                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                  ),
                                  style: TextStyle(color: AnaColors.front),
                                ),
                                // Se houver levantamentos inacabados, exiba-os aqui
                                if (unfinishedSurveys.isNotEmpty)
                                  ExpansionTile(

                                    title: Text('Não finalizados',
                                    style: TextStyle(color: AnaColors.champagne),),
                                    iconColor: AnaColors.champagne, // Cor da seta quando expandido
                                    collapsedIconColor: AnaColors.champagne, // Cor da seta quando colapsado
                                    textColor: AnaColors.champagne, // Cor do texto do título
                                    children: unfinishedSurveys.map<Widget>((survey) {
                                      return ListTile(
                                        title: Text(survey['name'],
                                        style: TextStyle(color: AnaColors.front),),
                                        onTap: () {
                                          // Atualize o estado com o nome selecionado e feche o diálogo
                                          setState(() {
                                            _surveyName = survey['name'];
                                            taEditado = AnaColors.front;
                                            _isSurveyNameSet = true;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }).toList(),
                                  ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancelar',
                              style: TextStyle(color: AnaColors.champagne),),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Verificar se o texto inserido não está vazio e se é um novo nome de levantamento.
                                if (_controller.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('O nome da unidade é obrigatório!'))
                                  );
                                } else {
                                  // Aqui você poderia incluir lógica para verificar se o nome do levantamento já existe
                                  // e somente chamar addSurveyToUnfinished se for um novo nome.

                                  // Primeiro, atualize o estado com o novo nome do levantamento.
                                  setState(() {
                                    _isSurveyNameSet = true;
                                    _surveyName = _controller.text;
                                    taEditado = AnaColors.front;
                                  });

                                  // Chama a função para adicionar o levantamento à lista de inacabados.
                                  await addSurveyToUnfinished(_surveyName);
                                  print("Teste: Isso deve aparecer depois do addSurvey!");

                                  // Fechar o diálogo após o levantamento ser adicionado.
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Text('OK',
                              style: TextStyle(color: AnaColors.champagne),),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return AlertDialog(
                          content: Text('Erro ao ler o arquivo: ${snapshot.error}'),
                        );
                      } else {
                        // Ainda carregando o arquivo
                        return AlertDialog(
                          content: CircularProgressIndicator(),
                        );
                      }
                    },
                  );
                } else {
                  // O diretório é nulo
                  return AlertDialog(
                    content: Text('Não foi possível encontrar o diretório de armazenamento externo.'),
                  );
                }
              } else if (snapshot.hasError) {
                return AlertDialog(
                  content: Text('Erro ao obter o diretório: ${snapshot.error}'),
                );
              }
            }
            // Por padrão, mostre um indicador de carregamento
            return AlertDialog(
              content: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}