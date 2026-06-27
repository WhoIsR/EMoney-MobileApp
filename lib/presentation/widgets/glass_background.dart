import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class GlassBackground extends StatelessWidget {
  final Widget child;

  const GlassBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -90,
            right: -100,
            child: _AmbientWash(
              size: 310,
              color: AppColors.primaryLight.withValues(alpha: 0.45),
            ),
          ),
          Positioned(
            left: -120,
            bottom: 120,
            child: _AmbientWash(
              size: 280,
              color: AppColors.champagne.withValues(alpha: 0.72),
            ),
          ),
          Positioned(
            right: 28,
            bottom: 40,
            child: _AmbientWash(
              size: 180,
              color: AppColors.mist.withValues(alpha: 0.86),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _AmbientWash extends StatelessWidget {
  final double size;
  final Color color;

  const _AmbientWash({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 44, sigmaY: 44),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
