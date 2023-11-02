import 'package:flutter/material.dart';
import 'dart:io';
import 'package:project_ana/globals.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class TelaVisualizarAsset extends StatefulWidget {
  final String? id;
  final String? tipo;
  final String? categoryId;
  final String? nome;
  final String? altName;
  final String? description;
  late final String? gps;
  late final String? imagePath;
  final String surveyName;

  TelaVisualizarAsset({
    required this.id,
    required this.nome,
    required this.altName,
    required this.description,
    required this.gps,
    required this.imagePath,
    required this.tipo,
    required this.categoryId,
    required this.surveyName,
  });

  @override
  _TelaVisualizarAssetState createState() => _TelaVisualizarAssetState();
}

class _TelaVisualizarAssetState extends State<TelaVisualizarAsset> {
  late TextEditingController _nomeController;
  late TextEditingController _altNameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.nome);
    _altNameController = TextEditingController(text: widget.altName);
    _descriptionController = TextEditingController(text: widget.description);
  }

  Widget? _buildGPSField() {
    if (widget.gps == null) {
      return null;
    }

    var gpsParts = widget.gps!.split(',');
    var lat = gpsParts[0];
    var lng = gpsParts.length > 1 ? gpsParts[1] : '';
    return _buildField('Localização:', "$lat\n${lng.substring(1)}");
  }

  Future<void> _deleteAsset() async {
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory?.path}/project_ana/files/${widget.surveyName}/survey.json';
    print(filePath);
    final file = File(filePath);

    if (!file.existsSync()) {
      // Se o arquivo não existir, exibir um erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Arquivo de dados não encontrado!")),
      );
      return;
    }

    final jsonData = json.decode(await file.readAsString());

    // Procurar pelo asset pelo 'id' em vez de 'nome'
    jsonData.removeWhere((item) => item['id'] == widget.id);

    // Escrever de volta no arquivo JSON os dados atualizados
    await file.writeAsString(json.encode(jsonData));

    // Se o arquivo de imagem existir, também o exclua
    if (widget.imagePath != null) {
      final imageFile = File(widget.imagePath!);
      if (imageFile.existsSync()) {
        await imageFile.delete();
      }
    }

    // Volta para a tela anterior com um sinal de que a deleção foi feita
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AnaColors.champagne, // Define a cor do ícone do botão de retornar
        ),
        title: Text(
          'Detalhes de Asset',
          style: TextStyle(color: AnaColors.desertSand),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: AnaColors.champagne),
            onPressed: () {
              // Mostrar um diálogo de confirmação antes de excluir
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirmar"),
                    content: Text("Tem certeza de que deseja excluir este asset?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("Cancelar"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text("Excluir"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Fecha o diálogo de confirmação
                          _deleteAsset();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: [
                _buildField('Nome:', _nomeController.text),
                _buildField('Nome Alternativo:', _altNameController.text),
                _buildField('Descrição:', _descriptionController.text),
                if (widget.gps != null) _buildGPSField()!,
              ],
            ),
            if (widget.imagePath != null)
              Expanded(
                child: widget.imagePath != null && File(widget.imagePath!).existsSync()
                    ? Image.file(
                  File(widget.imagePath!),
                  fit: BoxFit.cover,
                )
                    : Center(child: Text('Sem foto', style: TextStyle(color: AnaColors.front))),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: AnaColors.desertSand, fontWeight: FontWeight.bold)),
          SizedBox(height: 5), // Espaçamento para melhor visualização
          Text(text, style: TextStyle(color: AnaColors.front)),
        ],
      ),
    );
  }
}
