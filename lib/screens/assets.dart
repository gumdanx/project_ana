import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';
import 'dart:convert';
import 'package:project_ana/screens/show_asset.dart';

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
    try {
      String jsonData = await readJsonFromFile(widget.surveyName);
      print('JSON Data: $jsonData');  // Log do conteúdo lido do arquivo

      List data = jsonDecode(jsonData);
      setState(() {
        assets = data.map((item) => item as Map<String, dynamic>).toList();
      });

      print('Assets loaded: ${assets.length}');  // Log da quantidade de assets carregados
    } catch (error) {
      print('Erro ao carregar os assets: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Building assets view with ${assets.length} assets');  // Log no método build

    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: AnaColors.champagne, // Define a cor do ícone do botão de retornar
          ),
          title: Text('Ver Assets',
            style: TextStyle(color: AnaColors.desertSand),)),
      body: assets.isEmpty
          ? Center(child: Text('Sem assets disponíveis',
              style: TextStyle(color: Colors.white.withOpacity(0.5)),))  // Adicionando uma mensagem se a lista estiver vazia
          : ListView.builder(
        itemCount: assets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(assets[index]['name'] ?? 'Nome não disponível',
              style: TextStyle(color: AnaColors.front),),
            onTap: () async {
              // Espera pelo retorno da tela de visualização do asset
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaVisualizarAsset(
                    id: assets[index]['id'] ?? '',
                    nome: assets[index]['name'] ?? '',
                    categoryId: assets[index]['asset_type_number'] ?? '',
                    altName: assets[index]['alt_name'] ?? '',
                    description: assets[index]['description'] ?? '',
                    gps: assets[index]['gps'] ?? '',
                    imagePath: assets[index]['image'] ?? '',
                    surveyName: assets[index]['survey_name'] ?? '',
                    tipo: assets[index]['tipo'] ?? '',
                  ),
                ),
              );
              // Se algo foi retornado e é um sinal de que os dados mudaram, recarregar os assets
              if (result == true) {
                loadAssets();
              }
            },
          );
        },
      ),
    );
  }
}
