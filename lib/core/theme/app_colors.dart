import 'package:flutter/material.dart';

/// Neo-Brutalism color palette inspired by test.html.
class AppColors {
  AppColors._();

  // ── Background ──
  static const Color bg = Color(0xFF1a1a1a);
  static const Color screenBg = Color(0xFFd4e2d5);
  static const Color cardDark = Color(0xFF252525);

  // ── Accent colors ──
  static const Color orange = Color(0xFFff6b4a);
  static const Color yellow = Color(0xFFffd256);
  static const Color purple = Color(0xFF7f77ff);
  static const Color green = Color(0xFF4ade80);
  static const Color blue = Color(0xFF60a5fa);
  static const Color red = Color(0xFFef4444);
  static const Color pink = Color(0xFFf472b6);

  // ── Neutrals ──
  static const Color white = Color(0xFFffffff);
  static const Color black = Color(0xFF000000);
  static const Color gray50 = Color(0xFFf9fafb);
  static const Color gray100 = Color(0xFFf3f4f6);
  static const Color gray200 = Color(0xFFe5e7eb);
  static const Color gray300 = Color(0xFFd1d5db);
  static const Color gray400 = Color(0xFF9ca3af);
  static const Color gray500 = Color(0xFF6b7280);
  static const Color gray600 = Color(0xFF4b5563);

  static const Map<String, Color> toneBg = {
    'orange': orange, 'yellow': yellow, 'purple': purple,
    'green': green, 'blue': blue, 'red': red, 'pink': pink,
    'white': white, 'dark': cardDark,
  };

  static List<Color> tone(String name) {
    final c = toneBg[name] ?? white;
    final fg = (name == 'yellow' || name == 'white' || name == 'green') ? black : white;
    return [c, fg];
  }

  // ── Borders & Shadows ──
  static const double borderThick = 4.0;
  static const double borderMedium = 3.0;
  static const double borderThin = 2.0;

  static BoxShadow hardShadow = const BoxShadow(
    color: black, blurRadius: 0, offset: Offset(6, 6),
  );
  static BoxShadow hardShadowSm = const BoxShadow(
    color: black, blurRadius: 0, offset: Offset(4, 4),
  );
  static BoxShadow hardShadowXs = const BoxShadow(
    color: black, blurRadius: 0, offset: Offset(2, 2),
  );

  static List<BoxShadow> shadowPrimary = [hardShadow];
  static List<BoxShadow> shadowSoft = [hardShadowSm];
  static List<BoxShadow> shadowGlass = [hardShadow];
  static List<BoxShadow> shadowXs = [hardShadowXs];

  // ── Legacy compatibility ──
  static const Color primary = orange;
  static const Color primaryDark = cardDark;
  static const Color primaryLight = orange;
  static const Color accent = orange;
  static const Color ink = white;
  static const Color inkSecondary = gray400;
  static const Color slate400 = gray400;
  static const Color slate500 = gray500;
  static const Color slate600 = gray600;
  static const Color slate300 = gray300;
  static const Color glass = cardDark;
  static const Color glassFill = cardDark;
  static const Color glassLine = black;
  static const Color glassStroke = black;
  static const Color line = gray600;
  static const Color line2 = gray600;
  static const Color washLavender = purple;
  static const Color washPeach = orange;
  static const Color washTeal = blue;
  static const Color washAmber = yellow;
  static const Color washRose = pink;
  static const Color washBlue = blue;

  static const LinearGradient liquidGradient = LinearGradient(
    colors: [orange, orange],
  );
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [bg, bg],
  );
  static const LinearGradient walletGradient = LinearGradient(
    colors: [bg, cardDark],
  );
}
