import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projeto_ana/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class TelaTipoAsset extends StatefulWidget {
  final String tipo;
  final String categoryId;
  final String surveyName;

  TelaTipoAsset({
    required this.tipo,
    required this.categoryId,
    required this.surveyName,
  });

  @override
  _TelaTipoAssetState createState() => _TelaTipoAssetState();
}

class _TelaTipoAssetState extends State<TelaTipoAsset> {
  String? _gpsData;
  bool _gotGPSData = false;
  late TextEditingController _nomeController;
  late TextEditingController _nomeAlternativoController;
  late TextEditingController _descricaoController;
  File? _capturedImage; // para armazenar o arquivo da imagem capturada
  String? _assetId; // Adicionado para armazenar o ID do asset

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _nomeAlternativoController = TextEditingController();
    _descricaoController = TextEditingController();
    _assetId = Uuid().v4(); // Gera um novo ID único para o asset
  }

  void _updateGPSLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _gpsData = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
      _gotGPSData = true;
    });
  }

  Future<void> _captureImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File? savedImage = await saveImageToExternalStorage(
          File(pickedFile.path), widget.surveyName);
      setState(() {
        _capturedImage = savedImage ?? File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  String toJSON() {
    Map<String, dynamic> data = {
      "id": _assetId, // Aqui você adiciona o ID ao JSON
      "asset_type_number": widget.categoryId,
      "asset_type_name": widget.tipo,
      "name": _nomeController.text,
      "alt_name": _nomeAlternativoController.text,
      "description": _descricaoController.text,
      "gps": _gpsData,
      "image": _capturedImage?.path,
      "survey_name": widget.surveyName, // Altere conforme a necessidade
      "user": loggedInUsername,
    };

    return jsonEncode(data); // Transforma o mapa em uma string JSON
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AnaColors.back,
      appBar: AppBar(
        backgroundColor: AnaColors.back,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AnaColors.champagne),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Detalhes de ${widget.tipo}',
          style: TextStyle(color: AnaColors.desertSand),
        ),
      ),
      body: SingleChildScrollView(
        // Adicione SingleChildScrollView aqui
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _nomeController,
                style: TextStyle(color: AnaColors.front),
                decoration: InputDecoration(
                  labelText: 'Nome',
                  labelStyle: TextStyle(color: AnaColors.desertSand),
                  hintText: 'Nome ou identificador principal',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
              ),
              TextField(
                controller: _nomeAlternativoController,
                style: TextStyle(color: AnaColors.front),
                decoration: InputDecoration(
                  labelText: 'Nome Alternativo',
                  labelStyle: TextStyle(color: AnaColors.desertSand),
                  hintText: 'Nome ou identificador secundário',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
              ),
              TextField(
                controller: _descricaoController,
                style: TextStyle(color: AnaColors.front),
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  labelStyle: TextStyle(color: AnaColors.desertSand),
                  hintText: 'Informações úteis ou importantes',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AnaColors.darkGreen,
                ),
                child: Text(
                  _gpsData ?? 'GPS',
                  style: TextStyle(
                    color: _gotGPSData ? AnaColors.front : AnaColors.desertSand,
                  ),
                ),
                onPressed: _updateGPSLocation,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AnaColors.darkGreen,
                ),
                child: Text(
                  'Camera',
                  style: TextStyle(color: AnaColors.desertSand),
                ),
                onPressed: _captureImage,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AnaColors.front,
                ),
                child: Text(
                  'Salvar',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // Verifica se o campo 'Nome' está preenchido
                  if (_nomeController.text.isEmpty) {
                    // Mostra um alerta ou uma mensagem de erro
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Erro'),
                        content: Text('Por favor, preencha o campo Nome.'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                    return; // Não prossegue se o campo 'Nome' estiver vazio
                  }

                  // Se o campo 'Nome' estiver preenchido, prossegue com o salvamento
                  String jsonData = toJSON();
                  print(jsonData); // Imprime o JSON no console
                  await saveJsonToFile(jsonData, widget.surveyName); // Salva a string JSON em um arquivo
                  // Retorna para a tela anterior após salvar
                  Navigator.pop(context);
                },
              ),
              if (_capturedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Image.file(
                    _capturedImage!,
                    width: 100, // tamanho da miniatura
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
