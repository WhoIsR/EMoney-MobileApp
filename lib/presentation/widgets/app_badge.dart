import 'dart:ui';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final String tone;

  const AppBadge({super.key, required this.label, this.tone = 'blue'});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors[0].withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors[1].withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: colors[1],
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
