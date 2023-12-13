import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';

String? loggedInUsername;
String logo = 'assets/images/logo.png';
String biglogo = 'assets/images/fulllogo.png';

// Função para criar um arquivo ZIP e retornar o caminho do arquivo.
Future<String> createZip(List<File> files, String surveyName) async {
  final archive = Archive();
  for (File file in files) {
    final fileBytes = file.readAsBytesSync();
    print('Adding file: ${file.path}'); // Confirma que o arquivo foi lido
    archive.addFile(ArchiveFile(file.path.split("/").last, fileBytes.length, fileBytes));
  }

  final zipFileBytes = ZipEncoder().encode(archive);
  if (zipFileBytes == null) {
    throw Exception('Falha ao criar o arquivo ZIP.');
  }

  final dir = await getExternalStorageDirectory();
  final zipFile = File('${dir?.path}/project_ana/files/${surveyName}_${DateTime.now().millisecondsSinceEpoch}.zip');

  await zipFile.writeAsBytes(zipFileBytes);
  print('ZIP file created at: ${zipFile.path}'); // Confirma que o arquivo ZIP foi criado
  return zipFile.path; // Retorna o caminho do arquivo ZIP para ser usado depois.
}

// Função para criar ou atualizar o arquivo JSON com informações do levantamento.
Future<void> saveSurveyInfo(String surveyName, String zipPath) async {
  final dir = await getExternalStorageDirectory();
  final jsonFile = File('${dir?.path}/project_ana/files/survey_${surveyName}_info.json');

  Map<String, dynamic> surveyInfo = {
    'id': UniqueKey().toString(),
    'name': surveyName,
    'zipPath': zipPath,
  };

  String jsonContent = jsonEncode(surveyInfo);
  await jsonFile.writeAsString(jsonContent);
  print('Survey info saved: ${jsonFile.path}'); // Confirma que a informação foi salva
}

Future<File> _ensureDirectoryExists(String pathToFile) async {
  final file = File(pathToFile);
  final directory = file.parent;
  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
    print('Directory created: ${directory.path}'); // Confirma que o diretório foi criado
  }
  return file;
}

Future<String> readJsonFromFile(String surveyName) async {
  try {
    final directory = await getExternalStorageDirectory();
    final file = await _ensureDirectoryExists('${directory?.path}/project_ana/files/${surveyName}/survey.json');
    String jsonData = await file.readAsString();
    return jsonData;
  } catch (error) {
    return '[]';  // Retornar uma lista vazia em caso de erro
  }
}

Future<File?> saveImageToExternalStorage(File imageFile, String surveyName) async {
  if (await _requestStoragePermission()) {
    final directory = await getExternalStorageDirectory();
    final newPath = '${directory?.path}/project_ana/files/${surveyName}/images';
    final newDirectory = Directory(newPath);
    if (!newDirectory.existsSync()) {
      newDirectory.createSync(recursive: true);
    }
    final newImage = imageFile.copySync('$newPath/${imageFile.uri.pathSegments.last}');
    return newImage;
  }
  return null;
}

Future<bool> _requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    // Solicita permissões
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    return statuses[Permission.storage]!.isGranted;
  }
  return status.isGranted;
}

Future<void> saveJsonToFile(String jsonData, String surveyName) async {
  if (await _requestStoragePermission()) {
    final directory = await getExternalStorageDirectory();
    final newPath = '${directory?.path}/project_ana/files/${surveyName}';
    final newDirectory = Directory(newPath);
    if (!newDirectory.existsSync()) {
      newDirectory.createSync(recursive: true);
    }
    final file = File('$newPath/survey.json');

    List<dynamic> oldData = []; // Vai guardar os dados já existentes

    if (await file.exists()) {
      // Se o arquivo já existir, leia o conteúdo existente
      String oldContent = await file.readAsString();
      oldData = List<dynamic>.from(jsonDecode(oldContent));
    }

    Map<String, dynamic> newData = jsonDecode(jsonData);
    oldData.add(newData); // Adiciona o novo dado à lista antiga

    await file.writeAsString(jsonEncode(oldData)); // Reescreva o arquivo com os dados atualizados
    print("Arquivo JSON salvo em: ${file.path}");  // <-- Imprime o caminho do arquivo no console
  }
}

Future<Map<String, dynamic>> loadCategoriesFromAsset() async {
  String jsonString = await rootBundle.loadString('assets/assets_list.json');
  return jsonDecode(jsonString);
}

class AnaColors {
  static bool isDarkMode = true; // Controla o tema

  static MaterialColor get back => isDarkMode ? createMaterialColor(Dark.back) : createMaterialColor(Light.back);
  static MaterialColor get front => isDarkMode ? createMaterialColor(Dark.front) : createMaterialColor(Light.front);
  static MaterialColor get champagne => isDarkMode ? createMaterialColor(Dark.champagne) : createMaterialColor(Light.champagne);
  static MaterialColor get desertSand => isDarkMode ? createMaterialColor(Dark.desertSand) : createMaterialColor(Light.desertSand);
  static MaterialColor get darkGreen => isDarkMode ? createMaterialColor(Dark.darkGreen) : createMaterialColor(Light.darkGreen);

  static final _AnaColorsDark Dark = _AnaColorsDark();
  static final _AnaColorsLight Light = _AnaColorsLight();
}

class _AnaColorsDark {
  final Color back = Color(0xFF1E1E1E);
  final Color front = Color(0xFF259544);
  final Color champagne = Color(0xFFF3DFC1);
  final Color desertSand = Color(0xFFDDBEA8);
  final Color darkGreen = Color(0xFF1E352F);
// Adicione outras cores do tema escuro aqui
}

class _AnaColorsLight {
  final Color back = Color(0xFFF5F5F5);
  final Color front = Color(0xFF1E1E1E);
  final Color champagne = Color(0xAA1E1E1E); // Mantenha a mesma se adequada para ambos os temas
  final Color desertSand = Color(0x771E1E1E);
  final Color darkGreen = Color(0xFF81C784);
// Adicione outras cores do tema claro aqui
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}