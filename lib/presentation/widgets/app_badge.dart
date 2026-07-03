import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppBadge extends StatelessWidget {
  final String label;
  final String tone;

  const AppBadge({super.key, required this.label, this.tone = 'orange'});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.black, width: 1.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: colors[1],
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
