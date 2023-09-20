import 'package:project_ana/globals.dart';
import 'package:flutter/material.dart';

class TelaVerLevantamentos extends StatefulWidget {
  @override
  _TelaVerLevantamentosState createState() => _TelaVerLevantamentosState();
}

class _TelaVerLevantamentosState extends State<TelaVerLevantamentos> {
  List<String> levantamentos = [
    'Levantamento 1',
    'Levantamento 2',
    'Levantamento 3',
    // ... Adicione mais exemplos ou conecte com seu banco de dados
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Levantamentos Feitos',
          style: TextStyle(color: AnaColors.desertSand),),
      ),
      body: ListView.builder(
        itemCount: levantamentos.length,
        itemBuilder: (context, index) {
          return Card(
            color: AnaColors.front, // Define a cor do card aqui
            child: ListTile(
              title: Text(levantamentos[index],
                style: TextStyle(color: AnaColors.champagne),),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.share, color: AnaColors.champagne,), // Define a cor do ícone aqui
                    onPressed: () {
                      // Aqui, você pode adicionar a funcionalidade de compartilhar o levantamento
                      // Pode ser por meio de um email, WhatsApp ou qualquer outra plataforma que desejar.
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit, color: AnaColors.champagne,), // Define a cor do ícone aqui
                    onPressed: () {
                      // Aqui, você pode direcionar o usuário para a tela de edição do levantamento selecionado.
                    },
                  ),
                ],
              ),
              onTap: () {
                // Se desejar uma ação ao tocar no levantamento completo (e não apenas no ícone de edição)
              },
            ),
          );
        },
      ),
    );
  }
}
