import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A refined glassmorphism card with frosted glass effect.
/// Layers: backdrop blur → translucent fill → subtle inner highlight → border.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final double blur;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 24,
    this.color = AppColors.glass,
    this.border,
    this.boxShadow,
    this.margin,
    this.blur = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radius),
              border:
                  border ?? Border.all(color: AppColors.glassLine, width: 0.8),
              boxShadow: boxShadow ?? AppColors.shadowGlass,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
