import 'package:flutter/material.dart';

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

  static final MaterialColor darkBlue = createMaterialColor(darkBlueBase);
  static final MaterialColor caribbean = createMaterialColor(caribbeanBase);
  static final MaterialColor darkCyan = createMaterialColor(darkCyanBase);
  static final MaterialColor champagne = createMaterialColor(champagneBase);
  static final MaterialColor desertSand = createMaterialColor(desertSandBase);
}

/*
160f29  dark blue           roxo escuro
246a73  caribbean current   verde escuro
368f8b  dark cyan           verde medio
f3dfc1  champagne           amarelo claro
ddbea8  desert sand         amarelo medio
*/