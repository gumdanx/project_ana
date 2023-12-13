// main.dart
import 'package:flutter/material.dart';
import 'package:projeto_ana/screens/login.dart'; // ATENCAO A ESSE IMPORT
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projeto_ana/globals.dart';

void main() => runApp(MeuAplicativo());

class MeuAplicativo extends StatefulWidget {
  @override
  _MeuAplicativoState createState() => _MeuAplicativoState();
}

class _MeuAplicativoState extends State<MeuAplicativo> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verificarESolicitarPermissao(context);
    });
  }

  Future<void> _mostrarDialogoDePermissao(BuildContext context, bool permissoesNegadasParaSempre) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AnaColors.back,
          title: Text('Permissões Necessárias', style: TextStyle(color: AnaColors.front)),
          content: Text(
            'Este aplicativo precisa de permissões de câmera, arquivos e GPS para funcionar corretamente.',
            style: TextStyle(color: AnaColors.front),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Solicitar Novamente', style: TextStyle(color: AnaColors.champagne)),
              onPressed: () {
                Navigator.of(context).pop();
                if (permissoesNegadasParaSempre) {
                  // Direciona o usuário para as configurações do sistema
                  openAppSettings();
                } else {
                  // Ressolicitar as permissões
                  _verificarESolicitarPermissao(context); // Adicione o argumento 'context' aqui
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _verificarESolicitarPermissao(BuildContext context) async {
    // Verifica e solicita a permissão de localização
    LocationPermission permissaoLocalizacao = await Geolocator.checkPermission();
    if (permissaoLocalizacao == LocationPermission.denied) {
      permissaoLocalizacao = await Geolocator.requestPermission();
    }

    // Verifica e solicita a permissão da câmera
    PermissionStatus permissaoCamera = await Permission.camera.status;
    if (permissaoCamera.isDenied) {
      permissaoCamera = await Permission.camera.request();
    }

    // Verifica e solicita a permissão de armazenamento
    PermissionStatus permissaoArmazenamento = await Permission.storage.status;
    if (permissaoArmazenamento.isDenied) {
      permissaoArmazenamento = await Permission.storage.request();
    }

    // Verifica se alguma permissão foi negada ou negada permanentemente
    if (permissaoLocalizacao == LocationPermission.denied || permissaoCamera.isDenied || permissaoArmazenamento.isDenied) {
      await _mostrarDialogoDePermissao(context, false);
    }

    if (permissaoLocalizacao == LocationPermission.deniedForever || permissaoCamera.isPermanentlyDenied || permissaoArmazenamento.isPermanentlyDenied) {
      await _mostrarDialogoDePermissao(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto ANA',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaLogin(),
    );
  }
}
