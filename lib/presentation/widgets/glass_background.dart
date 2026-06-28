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
          // Top-right warm ambient wash
          Positioned(
            top: -80,
            right: -60,
            child: _AmbientWash(
              size: 320,
              color: AppColors.accentLight.withValues(alpha: 0.35),
            ),
          ),
          // Center-left cool ambient wash
          Positioned(
            left: -100,
            top: 200,
            child: _AmbientWash(
              size: 260,
              color: AppColors.primaryLight.withValues(alpha: 0.20),
            ),
          ),
          // Bottom-right soft glow
          Positioned(
            right: -40,
            bottom: -60,
            child: _AmbientWash(
              size: 240,
              color: AppColors.champagne.withValues(alpha: 0.70),
            ),
          ),
          // Small accent blip top-left
          Positioned(
            left: 40,
            top: 100,
            child: _AmbientWash(
              size: 120,
              color: AppColors.primarySurface.withValues(alpha: 0.50),
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
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
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
