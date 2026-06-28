import 'package:flutter/material.dart';

class AppColors {
  // ── Brand — deep navy + vibrant purple (Stripe/Revolut inspired) ──
  static const Color primary = Color(0xFF2F7D73);
  static const Color primaryLight = Color(0xFF5FB7A8);
  static const Color primaryDark = Color(0xFF1F5F57);
  static const Color primarySurface = Color(0xFFEAF7F4);
  static const Color primaryBorder = Color(0xFFBFE5DE);

  static const Color accent = Color(0xFF4C86F7);
  static const Color accentLight = Color(0xFF8EB8FF);
  static const Color accentSurface = Color(0xFFEAF2FF);

  // ── Semantic — vivid & clear ──
  static const Color green = Color(0xFF34A853);
  static const Color greenSurface = Color(0xFFEAF8EE);
  static const Color amber = Color(0xFFD88B2A);
  static const Color amberSurface = Color(0xFFFFF4E2);
  static const Color red = Color(0xFFE04F5F);
  static const Color redSurface = Color(0xFFFFEEF1);
  static const Color violet = Color(0xFF8D7BDA);
  static const Color violetSurface = Color(0xFFF2F0FF);

  // ── Neutral — cool steel grays ──
  static const Color ink = Color(0xFF1C1C1E);
  static const Color slate600 = Color(0xFF5F6368);
  static const Color slate500 = Color(0xFF777C83);
  static const Color slate400 = Color(0xFFA2A7AE);
  static const Color slate300 = Color(0xFFD2D7DD);
  static const Color line = Color(0xFFE7E9EC);
  static const Color line2 = Color(0xFFF3F4F6);

  // ── Surfaces ──
  static const Color bg = Color(0xFFF7F5F0);
  static const Color surface = Color(0xFFFCFAF7);
  static const Color mist = Color(0xFFEAF0EE);
  static const Color champagne = Color(0xFFFFF1DD);

  // ── Glass (cool blue-tinted) ──
  static const Color glass = Color(0xDDFCFBF8);
  static const Color glassStrong = Color(0xF5FFFEFC);
  static const Color glassLine = Color(0xB3FFFFFF);
  static const Color white = Color(0xFFFFFFFF);

  // ── Gradients ──
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFCF7), Color(0xFFF3F7F4), Color(0xFFE9F2F0)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentLight, accent],
  );

  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF7DD6C8), Color(0xFF2F7D73)],
  );

  static const LinearGradient liquidGradient = navyGradient;

  static const LinearGradient walletGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFEFF8F6), Color(0xFFFFF3E5)],
  );

  static const LinearGradient purpleNavyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFEFF8F6), Color(0xFFFFF3E5)],
  );

  static const LinearGradient darkHeroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8FBFA), Color(0xFFEAF2F0), Color(0xFFFFF5E8)],
  );

  // ── Shadows ──
  static List<BoxShadow> shadowCard = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 30,
      spreadRadius: 0,
      offset: Offset(0, 14),
    ),
  ];

  static List<BoxShadow> shadowGlass = [
    BoxShadow(
      color: Color(0x12000000),
      blurRadius: 34,
      spreadRadius: -10,
      offset: Offset(0, 20),
    ),
    BoxShadow(
      color: Color(0x66FFFFFF),
      blurRadius: 8,
      spreadRadius: -5,
      offset: Offset(0, -3),
    ),
  ];

  static List<BoxShadow> shadowSoft = [
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 18,
      spreadRadius: 0,
      offset: Offset(0, 8),
    ),
  ];

  static List<BoxShadow> shadowPrimary = [
    BoxShadow(
      color: Color(0x332F7D73),
      blurRadius: 22,
      spreadRadius: -4,
      offset: Offset(0, 12),
    ),
  ];

  static List<BoxShadow> shadowPurple = [
    BoxShadow(
      color: Color(0x1A2F7D73),
      blurRadius: 32,
      spreadRadius: -8,
      offset: Offset(0, 16),
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
