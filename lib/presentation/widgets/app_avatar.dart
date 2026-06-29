import 'dart:ui';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final String name;
  final double size;
  final Color? bg;
  final String? imageUrl;

  const AppAvatar({
    super.key,
    required this.name,
    this.size = 44,
    this.bg,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final palette = [
      AppColors.primary,
      const Color(0xFF16A571),
      const Color(0xFF7A5AF8),
      const Color(0xFFD4A04A),
      const Color(0xFFE5484D),
      const Color(0xFF0EA5E9),
    ];
    final auto =
        palette[(name.isNotEmpty ? name.codeUnitAt(0) : 0) % palette.length];
    final initials = name
        .split(' ')
        .take(2)
        .map((s) => s.isNotEmpty ? s[0].toUpperCase() : '')
        .join();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: imageUrl != null
            ? AppColors.glass
            : (bg ?? auto).withValues(alpha: 0.85),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 0.5,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: imageUrl != null
          ? Image.network(imageUrl!, fit: BoxFit.cover)
          : Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: size * 0.36,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }
}
