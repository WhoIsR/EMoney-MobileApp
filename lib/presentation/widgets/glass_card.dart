import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A refined glassmorphism card with strong frosted glass effect.
/// Layers: backdrop blur → translucent fill → subtle inner highlight → border.
/// Fill is ~82% opaque — bright enough for readable text while retaining glass feel.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color color;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final bool elevated;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 22,
    this.color = AppColors.glassFill,
    this.border,
    this.boxShadow,
    this.margin,
    this.blur = 40,
    this.elevated = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget innerContainer = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border:
            border ?? Border.all(color: AppColors.glassStroke, width: 1.0),
        boxShadow: boxShadow ??
            (elevated ? AppColors.shadowPrimary : AppColors.shadowGlass),
      ),
      child: child,
    );

    Widget card = Container(
      margin: margin,
      child: blur > 0
          ? ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                child: innerContainer,
              ),
            )
          : innerContainer,
    );

    if (onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        child: card,
      );
    }

    return card;
  }
}
