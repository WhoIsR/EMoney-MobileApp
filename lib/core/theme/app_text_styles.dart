import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── Brutalism labels (small uppercase) ──
  static const TextStyle label = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 9,
    fontWeight: FontWeight.w900,
    color: AppColors.gray400,
    letterSpacing: 1.0,
  );

  static const TextStyle labelWhite = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 9,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
    letterSpacing: 1.0,
  );

  static const TextStyle labelBlack = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 9,
    fontWeight: FontWeight.w900,
    color: AppColors.black,
    letterSpacing: 1.0,
  );

  // ── Balance / amount ──
  static const TextStyle balance = TextStyle(
    fontFamily: 'SpaceGrotesk',
    fontSize: 28,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
    letterSpacing: -1.0,
  );

  static const TextStyle amount = TextStyle(
    fontFamily: 'SpaceGrotesk',
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    letterSpacing: -0.5,
  );

  // ── Headings ──
  static const TextStyle h1 = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 22,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
    letterSpacing: -0.5,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 18,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
    letterSpacing: -0.3,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 15,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );

  // ── Body ──
  static const TextStyle body = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const TextStyle bodyMuted = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.gray400,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.gray400,
  );

  // ── Badge / tag ──
  static const TextStyle tag = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 8,
    fontWeight: FontWeight.w900,
    color: AppColors.black,
    letterSpacing: 0.5,
  );

  static const TextStyle tagWhite = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 8,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  // ── Button ──
  static const TextStyle button = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: AppColors.black,
    letterSpacing: 0.3,
  );

  static const TextStyle buttonSmall = TextStyle(
    fontFamily: 'PlusJakartaSans',
    fontSize: 9,
    fontWeight: FontWeight.w900,
    color: AppColors.black,
    letterSpacing: 0.3,
  );
}
