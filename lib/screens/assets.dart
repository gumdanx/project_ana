import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:project_ana/screens/asset_data.dart';

class TelaVerAssets extends StatefulWidget {
  final String surveyName;
  TelaVerAssets({required this.surveyName});
  @override
  _TelaVerAssetsState createState() => _TelaVerAssetsState();
}

class _TelaVerAssetsState extends State<TelaVerAssets> {
  List<Map<String, dynamic>> assets = [];

  @override
  void initState() {
    super.initState();
    loadAssets();
  }

  void loadAssets() async {
    String jsonData = await readJsonFromFile(widget.surveyName);
    List data = jsonDecode(jsonData);
    setState(() {
      assets = data.map((item) => item as Map<String, dynamic>).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ver Assets',
        style: TextStyle(color: AnaColors.desertSand),)),
      body: ListView.builder(
        itemCount: assets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(assets[index]['name'],  // Corrigindo aqui
              style: TextStyle(color: AnaColors.front),),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TelaTipoAsset(nome: assets[index]['name'],  // E aqui
                            categoryId: assets[index]['categoryId'],
                            surveyName: assets[index]['surveyName'])));
            },
          );
        },
      ),
    );
  }
}
