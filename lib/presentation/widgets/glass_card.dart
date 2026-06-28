import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A refined glassmorphism card with frosted glass effect and inner glow.
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
  final bool elevated;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = 22,
    this.color = AppColors.glass,
    this.border,
    this.boxShadow,
    this.margin,
    this.blur = 28,
    this.elevated = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
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
                  border ?? Border.all(color: AppColors.glassLine, width: 1.0),
              boxShadow: boxShadow ??
                  (elevated ? AppColors.shadowPrimary : AppColors.shadowGlass),
            ),
            child: _InnerGlow(radius: radius, child: child),
          ),
        ),
      ),
    );

    if (onTap != null) {
      card = _HoverLift(onTap: onTap!, child: card);
    }

    return card;
  }
}

/// Subtle white inner glow at the top edge for depth.
class _InnerGlow extends StatelessWidget {
  final Widget child;
  final double radius;
  const _InnerGlow({required this.child, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        // Thin highlight line at top
        Positioned(
          top: 0,
          left: radius * 0.5,
          right: radius * 0.5,
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.62),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Subtle scale + shadow lift on press (like Apple Music cards).
class _HoverLift extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  const _HoverLift({required this.child, required this.onTap});

  @override
  State<_HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<_HoverLift>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) => Transform.scale(
          scale: _scale.value,
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}
