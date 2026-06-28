import 'package:flutter/material.dart';

class AppColors {
  // ── Brand — elegant deep navy + warm gold ──
  static const Color primary = Color(0xFF2C3E50);
  static const Color primaryLight = Color(0xFF5A7A96);
  static const Color primaryDark = Color(0xFF1A2530);
  static const Color primarySurface = Color(0xFFEEF2F6);
  static const Color primaryBorder = Color(0xFFD0D8E2);

  static const Color accent = Color(0xFFC49B6E);
  static const Color accentLight = Color(0xFFE8D5C8);
  static const Color accentSurface = Color(0xFFFDF5EA);

  // ── Semantic — muted, sophisticated ──
  static const Color green = Color(0xFF5A8A70);
  static const Color greenSurface = Color(0xFFEAF3ED);
  static const Color amber = Color(0xFFC49B6E);
  static const Color amberSurface = Color(0xFFFFF5E5);
  static const Color red = Color(0xFFC46A6A);
  static const Color redSurface = Color(0xFFFDEDED);
  static const Color violet = Color(0xFF7A7AB8);
  static const Color violetSurface = Color(0xFFF0F0FA);

  // ── Neutral — warm grays ──
  static const Color ink = Color(0xFF1C2028);
  static const Color slate600 = Color(0xFF4A5060);
  static const Color slate500 = Color(0xFF7A8090);
  static const Color slate400 = Color(0xFFA8AEB8);
  static const Color slate300 = Color(0xFFD0D4DC);
  static const Color line = Color(0xFFE2E5EA);
  static const Color line2 = Color(0xFFF0F2F4);

  // ── Surfaces ──
  static const Color bg = Color(0xFFF7F5F2);
  static const Color surface = Color(0xFFFCFAF8);
  static const Color mist = Color(0xFFEEF0F2);
  static const Color champagne = Color(0xFFF5EFE8);

  // ── Glass (over warm bg) ──
  static const Color glass = Color(0xDDFCFAF8);
  static const Color glassStrong = Color(0xF2FCFAF8);
  static const Color glassLine = Color(0x4DFFFFFF);
  static const Color white = Color(0xFFFFFFFF);

  // ── Gradients ──
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.55, 1.0],
    colors: [Color(0xFFFFFFFF), Color(0xFFF0EEEA), Color(0xFFE8E0D6)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentLight, accent],
  );

  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLight, primary],
  );

  // ── Shadows ──
  static List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x1A2C3E50),
      blurRadius: 28,
      spreadRadius: 0,
      offset: Offset(0, 4),
    ),
  ];

  static List<BoxShadow> shadowGlass = [
    BoxShadow(
      color: Color(0x1F2C3E50),
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
      color: Color(0x142C3E50),
      blurRadius: 16,
      spreadRadius: 0,
      offset: Offset(0, 2),
    ),
  ];

  static List<BoxShadow> shadowPrimary = [
    BoxShadow(
      color: Color(0x332C3E50),
      blurRadius: 24,
      spreadRadius: 0,
      offset: Offset(0, 10),
    ),
  ];

  // ── Tone map for FeatureIcon & AppBadge ──
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
