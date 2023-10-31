import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class TelaTipoAsset extends StatefulWidget {
  final String? tipo;
  final String? categoryId;
  final String? nome;
  final String surveyName;

  TelaTipoAsset({this.tipo, this.nome, required this.categoryId, required this.surveyName})
      : assert(tipo != null || nome != null,
  'Ao menos "tipo" ou "nome" deve ser fornecido.');

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

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _nomeAlternativoController = TextEditingController();
    _descricaoController = TextEditingController();
  }

  void _updateGPSLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _gpsData = 'Lat: ${position.latitude}, Lng: ${position.longitude}';
      _gotGPSData = true;
    });
  }

  Future<void> _captureImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File? savedImage = await saveImageToExternalStorage(File(pickedFile.path));
      setState(() {
        _capturedImage = savedImage ?? File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  String toJSON() {
    Map<String, dynamic> data = {
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
      appBar: AppBar(title: Text('Detalhes de ${widget.nome ?? widget.tipo}',
        style: TextStyle(color: AnaColors.desertSand),)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                labelStyle: TextStyle(color: AnaColors.desertSand),
                hintText: 'Nome ou identificador principal',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
            TextField(
              controller: _nomeAlternativoController,
              decoration: InputDecoration(
                labelText: 'Nome Alternativo (opcional)',
                labelStyle: TextStyle(color: AnaColors.desertSand),
                hintText: 'Nome ou identificador secundário',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
                labelStyle: TextStyle(color: AnaColors.desertSand),
                hintText: 'Informações úteis ou importantes',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ),
            ElevatedButton(
              child: Text(_gpsData ?? 'Salvar localização GPS',
                style: TextStyle(
                  color: _gotGPSData ? AnaColors.front : AnaColors.desertSand,
                ),
              ),
              onPressed: _updateGPSLocation,
            ),
            ElevatedButton(
              child: Text('Camera',
                style: TextStyle(color: AnaColors.desertSand),),
              onPressed: _captureImage,
            ),
            ElevatedButton(
              child: Text('Salvar',
                style: TextStyle(color: AnaColors.desertSand),),
              onPressed: () async {
                String jsonData = toJSON();
                await saveJsonToFile(jsonData, widget.surveyName); // Salve a string JSON em um arquivo
                // Lógica para salvar os dados
                // Após salvar, retorne para a tela anterior
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
    );
  }
}
