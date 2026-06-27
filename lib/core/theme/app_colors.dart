import 'package:flutter/material.dart';

class AppColors {
  // Soft modern palette
  static const Color primary = Color(0xFF2A8C82);
  static const Color primaryLight = Color(0xFF8FDCD3);
  static const Color primaryDark = Color(0xFF1C6B64);
  static const Color primarySurface = Color(0xFFE7F6F3);
  static const Color primaryBorder = Color(0xFFBFE7E1);

  // Semantic
  static const Color green = Color(0xFF16A571);
  static const Color greenSurface = Color(0xFFE8F8F2);
  static const Color amber = Color(0xFFC08A3E);
  static const Color amberSurface = Color(0xFFFFF5E5);
  static const Color red = Color(0xFFE5484D);
  static const Color redSurface = Color(0xFFFDECED);
  static const Color violet = Color(0xFF6F7FB8);
  static const Color violetSurface = Color(0xFFF0F2FA);

  // Neutral
  static const Color ink = Color(0xFF22302F);
  static const Color slate600 = Color(0xFF596D69);
  static const Color slate500 = Color(0xFF7C8B88);
  static const Color slate400 = Color(0xFFA8B5B2);
  static const Color slate300 = Color(0xFFD2DBD8);
  static const Color line = Color(0xFFE2EAE7);
  static const Color line2 = Color(0xFFF0F4F2);
  static const Color bg = Color(0xFFF7F8F4);
  static const Color mist = Color(0xFFEFF8F6);
  static const Color champagne = Color(0xFFFFF4DF);
  static const Color glass = Color(0x73FFFFFF);
  static const Color glassStrong = Color(0xCCFFFFFF);
  static const Color glassLine = Color(0xE6FFFFFF);
  static const Color white = Color(0xFFFFFFFF);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.6, 1.0],
    colors: [Color(0xFFFFFFFF), Color(0xFFDFF5F1), Color(0xFFFFEBC4)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primary],
  );

  // Shadows
  static List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x1A5E756F),
      blurRadius: 28,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];
  static List<BoxShadow> shadowGlass = [
    BoxShadow(
      color: Color(0x1F607C76),
      blurRadius: 42,
      spreadRadius: -8,
      offset: Offset(0, 22),
    ),
    BoxShadow(
      color: Color(0x14FFFFFF),
      blurRadius: 2,
      spreadRadius: 1,
      offset: Offset(0, -1),
    ),
  ];
  static List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Color(0x145E756F),
      blurRadius: 16,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
  ];
  static List<BoxShadow> shadowPrimary = [
    BoxShadow(
      color: Color(0x332A8C82),
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 10),
    ),
  ];

  // Tone map for FeatureIcon
  static Map<String, List<Color>> tones = {
    'blue': [primarySurface, primary],
    'green': [greenSurface, green],
    'amber': [amberSurface, amber],
    'red': [redSurface, red],
    'violet': [violetSurface, violet],
    'slate': [bg, slate600],
  };

  static List<Color> tone(String name) => tones[name] ?? tones['blue']!;
}
