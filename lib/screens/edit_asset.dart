import 'package:flutter/material.dart';

class TelaEditarAsset extends StatefulWidget {
  final String?
      asset; // Null indica modo de criação; valor indica modo de edição

  TelaEditarAsset({this.asset, required String nome});

  @override
  _TelaEditarAssetState createState() => _TelaEditarAssetState();
}

class _TelaEditarAssetState extends State<TelaEditarAsset> {
  late TextEditingController nomeController;
  late TextEditingController nomeAlternativoController;
  late TextEditingController descricaoController;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.asset ?? '');
    nomeAlternativoController = TextEditingController();
    descricaoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.asset == null ? 'Novo Asset' : 'Editar Asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nomeAlternativoController,
              decoration: InputDecoration(
                labelText: 'Nome Alternativo (opcional)',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descricaoController,
              decoration: InputDecoration(
                labelText: 'Descrição',
              ),
            ),
            // Adicione campos para localização GPS, opção de câmera etc.
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Salvar o asset (você pode adicionar a funcionalidade de salvar no banco de dados local aqui)
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
