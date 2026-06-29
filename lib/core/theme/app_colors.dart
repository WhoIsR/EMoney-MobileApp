import 'package:flutter/material.dart';

class AppColors {
  // ── Brand — premium indigo-blue (richer than system blue) ──
  static const Color primary = Color(0xFF3B3DFF);
  static const Color primaryLight = Color(0xFF6B6FFF);
  static const Color primaryDark = Color(0xFF2A2BBF);
  static const Color primarySurface = Color(0xFFEEF0FF);
  static const Color primaryBorder = Color(0xFFC8CCFF);

  static const Color accent = Color(0xFFFF6B35); // warm coral
  static const Color accentLight = Color(0xFFFF8F66);
  static const Color accentSurface = Color(0xFFFFF0EB);

  // ── Semantic ──
  static const Color green = Color(0xFF34C759);
  static const Color greenSurface = Color(0xFFE8F8ED);
  static const Color amber = Color(0xFFFFC043);
  static const Color amberSurface = Color(0xFFFFFAEB);
  static const Color red = Color(0xFFFF3B30);
  static const Color redSurface = Color(0xFFFFECEB);
  static const Color violet = Color(0xFFAF52DE);
  static const Color violetSurface = Color(0xFFF5EEFC);

  // ── Neutral ──
  static const Color ink = Color(0xFF1C1C1E);
  static const Color inkSecondary = Color(0xFF3A3A3C);
  static const Color slate600 = Color(0xFF48484A);
  static const Color slate500 = Color(0xFF636366);
  static const Color slate400 = Color(0xFF8E8E93);
  static const Color slate300 = Color(0xFFAEAEB2);
  static const Color line = Color(0xFFC6C6C8);
  static const Color line2 = Color(0xFFE0E0E0);

  // ── Surfaces ──
  static const Color white = Color(0xFFFFFFFF);
  static const Color bg = Color(0xFFF0EFF5);
  static const Color surface = Color(0xFFFFFFFF);

  // ── Glass (low opacity so background washes show through) ──
  static const Color glassFill = Color(0xD0FEFEFE); // ~82% opacity — bright glass
  static const Color glassStroke = Color(0x3AFFFFFF);
  static const Color glassShadow = Color(0x18000000);
  static const Color glass = glassFill;
  static const Color glassStrong = Color(0xE6FEFEFE); // ~90% — near-solid header
  static const Color glassLine = glassStroke;

  // ── Gradients ──

  /// Cool silver-blue titanium gradient (iOS style)
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFEBF3FC), // cool ice blue
      Color(0xFFF0EFF5), // light platinum
      Color(0xFFE4ECF7), // soft silver blue
    ],
  );

  /// Dark indigo → deep navy — for the hero balance card
  static const LinearGradient purpleNavyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF5B5FFF),
      Color(0xFF2528CC),
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentLight, accent],
  );

  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6B6FFF), Color(0xFF3B3DFF)],
  );

  static const LinearGradient liquidGradient = navyGradient;

  // Premium light titanium card gradient (iOS style)
  static const LinearGradient walletGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF2F2F7),
    ],
  );

  // ── Background wash colors (cool titanium & ice blue, used in GlassBackground) ──
  static const Color washLavender = Color(0xFFD0D7FF); // soft blue-lavender
  static const Color washPeach = Color(0xFFD4ECFC);    // cool blue-gray
  static const Color washTeal = Color(0xFFE0F5F0);     // soft light mint
  static const Color washAmber = Color(0xFFE8F0FE);    // ice blue-gray
  static const Color washRose = Color(0xFFE4ECFF);     // ice blue
  static const Color washBlue = Color(0xFFCDE2FF);     // clean soft blue

  // ── Shadows ──
  static List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x12000000),
      blurRadius: 40,
      spreadRadius: -8,
      offset: Offset(0, 16),
    ),
  ];

  static List<BoxShadow> shadowGlass = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 32,
      spreadRadius: -8,
      offset: Offset(0, 12),
    ),
    BoxShadow(
      color: Color(0x0CFFFFFF),
      blurRadius: 8,
      spreadRadius: -4,
      offset: Offset(0, -2),
    ),
  ];

  static List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Color(0x08000000),
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];

  static List<BoxShadow> shadowPrimary = [
    BoxShadow(
      color: Color(0x303B3DFF),
      blurRadius: 28,
      spreadRadius: -6,
      offset: Offset(0, 16),
    ),
  ];

  static List<BoxShadow> shadowPurple = [
    BoxShadow(
      color: Color(0x303B3DFF),
      blurRadius: 32,
      spreadRadius: -8,
      offset: Offset(0, 20),
    ),
  ];

  // ── Tone map ──
  static Map<String, List<Color>> tones = {
    'blue': [primarySurface, primary],
    'green': [greenSurface, green],
    'amber': [amberSurface, amber],
    'red': [redSurface, red],
    'violet': [violetSurface, violet],
    'slate': [bg, slate600],
    'glass': [Color(0x24FFFFFF), Colors.white],
    'glass_dark': [Color(0x12000000), Color(0xFF1C1C1E)],
  };

  static List<Color> tone(String name) => tones[name] ?? tones['blue']!;
}
