import 'package:flutter/material.dart';

class AppTheme {
  // Palet retro-fridge neo-brutalism
  static const Color fridge = Color(0xFFE3EEEB);
  static const Color fridgeDeep = Color(0xFFCFE0DB);
  static const Color ink = Color(0xFF13292B);
  static const Color mute = Color(0xFF4E6668);
  static const Color paper = Color(0xFFFFFFFF);
  static const Color butter = Color(0xFFFFE680);
  static const Color chili = Color(0xFFD8382A);
  static const Color chiliDark = Color(0xFFB52B1F);
  static const Color pandan = Color(0xFF1F6B4B);

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: fridge,
    colorScheme: ColorScheme.fromSeed(
      seedColor: pandan,
      primary: chili,
      surface: paper,
    ),
  );
}
