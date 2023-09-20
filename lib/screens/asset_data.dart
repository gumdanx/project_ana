import 'package:flutter/material.dart';
import 'package:project_ana/globals.dart';

class TelaTipoAsset extends StatefulWidget {
  final String tipo;

  TelaTipoAsset({required this.tipo});

  @override
  _TelaTipoAssetState createState() => _TelaTipoAssetState();
}

class _TelaTipoAssetState extends State<TelaTipoAsset> {
  late TextEditingController _nomeController;
  late TextEditingController _nomeAlternativoController;
  late TextEditingController _descricaoController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController();
    _nomeAlternativoController = TextEditingController();
    _descricaoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes de ${widget.tipo}',
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
              ),
            ),
            TextField(
              controller: _nomeAlternativoController,
              decoration: InputDecoration(
                labelText: 'Nome Alternativo (opcional)',
              ),
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            ElevatedButton(
              child: Text('Salvar localização GPS'),
              onPressed: () {
                // Lógica para salvar localização GPS
              },
            ),
            ElevatedButton(
              child: Text('Camera'),
              onPressed: () {
                // Lógica para acessar a câmera e tirar foto ou filmar
              },
            ),
            ElevatedButton(
              child: Text('Salvar'),
              onPressed: () {
                // Lógica para salvar os dados
                // Após salvar, retorne para a tela anterior
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
