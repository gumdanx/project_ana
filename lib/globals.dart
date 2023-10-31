import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

String? loggedInUsername;

Future<String> readJsonFromFile(String surveyName) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/${surveyName}/survey.json');
    String jsonData = await file.readAsString();
    return jsonData;
  } catch (error) {
    return '[]';  // Retornar uma lista vazia em caso de erro
  }
}

Future<File?> saveImageToExternalStorage(File imageFile) async {
  if (await _requestStoragePermission()) {
    final directory = await getExternalStorageDirectory();
    final newPath = '${directory?.path}/project_ana/images';
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
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/${surveyName}/survey.json');

  // Verifique se o arquivo existe
  if (await file.exists()) {
    String oldContent = await file.readAsString();
    List<dynamic> oldData = jsonDecode(oldContent);

    Map<String, dynamic> newData = jsonDecode(jsonData);
    oldData.add(newData); // Adiciona o novo dado à lista antiga

    await file.writeAsString(jsonEncode(oldData)); // Reescreva o arquivo com os dados atualizados
  } else {
    await file.writeAsString(jsonData); // Se o arquivo não existir, apenas escreva o JSON
  }
}


Future<Map<String, dynamic>> loadCategoriesFromAsset() async {
  String jsonString = await rootBundle.loadString('assets/assets_list.json');
  return jsonDecode(jsonString);
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

class AnaColors {
  AnaColors._();

  static const Color darkBlueBase = Color(0xFF160F29);
  static const Color caribbeanBase = Color(0xFF246A73);
  static const Color darkCyanBase = Color(0xFF368F8B);
  static const Color champagneBase = Color(0xFFF3DFC1);
  static const Color desertSandBase = Color(0xFFDDBEA8);

  static const Color vanDykeBase = Color(0xFF4B3B40);
  static const Color coyoteBase = Color(0xFF82735C);
  static const Color olivineBase = Color(0xFF9DB17C);
  static const Color celadonBase = Color(0xFF9CDE9F);
  static const Color teaGreenBase = Color(0xFFD1F5BE);

  static const Color richBlackBase = Color(0xFF001011);
  static const Color darkGreenBase = Color(0xFF1E352F);
  static const Color brunswickGreenBase = Color(0xFF335145);
  static const Color tigersEyeBase = Color(0xFFBC6C25);
  static const Color earthYellowBase = Color(0xFFDDA14E);

  static const Color backBase = Color(0xFF1E1E1E);
  static final MaterialColor back = createMaterialColor(backBase);
  static const Color frontBase = Color(0xFF259544);
  static final MaterialColor front = createMaterialColor(frontBase);

  static final MaterialColor darkBlue = createMaterialColor(darkBlueBase);
  static final MaterialColor caribbean = createMaterialColor(caribbeanBase);
  static final MaterialColor darkCyan = createMaterialColor(darkCyanBase);
  static final MaterialColor champagne = createMaterialColor(champagneBase);
  static final MaterialColor desertSand = createMaterialColor(desertSandBase);

  static final MaterialColor vanDyke = createMaterialColor(vanDykeBase);
  static final MaterialColor coyote = createMaterialColor(coyoteBase);
  static final MaterialColor olivine = createMaterialColor(olivineBase);
  static final MaterialColor celadon = createMaterialColor(celadonBase);
  static final MaterialColor teaGreen = createMaterialColor(teaGreenBase);

  static final MaterialColor richBlack = createMaterialColor(richBlackBase);
  static final MaterialColor darkGreen = createMaterialColor(darkGreenBase);
  static final MaterialColor brunswickGreen = createMaterialColor(brunswickGreenBase);
  static final MaterialColor tigersEye = createMaterialColor(tigersEyeBase);
  static final MaterialColor earthYellow = createMaterialColor(earthYellowBase);
}
