// arquivo tela_ver_levantamentos.dart

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
        title: Text('Levantamentos Feitos'),
      ),
      body: ListView.builder(
        itemCount: levantamentos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(levantamentos[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      // Aqui, você pode adicionar a funcionalidade de compartilhar o levantamento
                      // Pode ser por meio de um email, WhatsApp ou qualquer outra plataforma que desejar.
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
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
