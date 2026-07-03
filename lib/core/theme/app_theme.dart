import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.bg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.orange,
        secondary: AppColors.purple,
        surface: AppColors.cardDark,
        error: AppColors.red,
        onPrimary: AppColors.black,
        onSecondary: AppColors.white,
        onSurface: AppColors.white,
      ),

      fontFamily: 'PlusJakartaSans',

      // ── AppBar ──
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: AppColors.white,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: AppColors.white),
      ),

      // ── Bottom sheet ──
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.bg,
        modalBackgroundColor: AppColors.bg,
      ),

      // ── Text ──
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          fontFamily: 'PlusJakartaSans',
          color: AppColors.white,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          fontFamily: 'PlusJakartaSans',
          color: AppColors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
          fontFamily: 'PlusJakartaSans',
          color: AppColors.white,
          letterSpacing: -0.3,
        ),
        titleMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
          fontFamily: 'PlusJakartaSans',
          color: AppColors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: 'PlusJakartaSans',
          color: AppColors.white,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'PlusJakartaSans',
          color: AppColors.gray400,
        ),
        labelSmall: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w900,
          fontFamily: 'PlusJakartaSans',
          color: AppColors.gray400,
          letterSpacing: 0.5,
        ),
      ),

      // ── Divider ──
      dividerTheme: const DividerThemeData(
        color: AppColors.gray600,
        thickness: 1,
        space: 0,
      ),

      // ── Input decoration ──
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.black, width: 3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.black, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.yellow, width: 3),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.red, width: 3),
        ),
        hintStyle: const TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 14,
          color: AppColors.gray500,
          fontWeight: FontWeight.w600,
        ),
        labelStyle: const TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 13,
          color: AppColors.gray400,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
