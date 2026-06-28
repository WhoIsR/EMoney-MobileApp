import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A rich ambient glassmorphism background with layered gradient washes
/// that create depth and flow behind frosted glass elements.
/// Updated with more vibrant, defined washes so glass effects pop.
class GlassBackground extends StatelessWidget {
  final Widget child;
  final bool animate;
  final bool dark;

  const GlassBackground({
    super.key,
    required this.child,
    this.animate = true,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: dark ? AppColors.darkHeroGradient : AppColors.primaryGradient,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Large vibrant ambient wash (top-right) ──
          _buildWash(
            top: size.height * -0.08,
            right: size.width * -0.12,
            size: min(size.width * 1.3, 420),
            color: AppColors.primaryLight.withValues(alpha: 0.22),
            animate: animate,
          ),
          // ── Deep navy wash (mid-left) ──
          _buildWash(
            left: size.width * -0.15,
            top: size.height * 0.22,
            size: min(size.width * 1.0, 340),
            color: AppColors.champagne.withValues(alpha: 0.42),
            animate: animate,
          ),
          // ── Bright purple accent (bottom-right) ──
          _buildWash(
            right: size.width * -0.10,
            bottom: size.height * -0.06,
            size: min(size.width * 0.9, 300),
            color: AppColors.accentSurface.withValues(alpha: 0.32),
          ),
          // ── Warm amber glow (top-left) ──
          _buildWash(
            left: size.width * -0.05,
            top: size.height * 0.08,
            size: 180,
            color: AppColors.white.withValues(alpha: 0.48),
          ),
          // ── Small bright accent (mid-right) ──
          _buildWash(
            right: size.width * 0.08,
            top: size.height * 0.42,
            size: 130,
            color: AppColors.greenSurface.withValues(alpha: 0.36),
          ),
          // ── Soft mist (bottom-center) ──
          _buildWash(
            left: size.width * 0.25,
            bottom: size.height * 0.08,
            size: 150,
            color: AppColors.mist.withValues(alpha: 0.46),
          ),
          child,
        ],
      ),
    );
  }

  Widget _buildWash({
    double? left,
    double? top,
    double? right,
    double? bottom,
    required double size,
    required Color color,
    bool animate = false,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: animate
          ? _AnimatedWash(size: size, color: color)
          : _StaticWash(size: size, color: color),
    );
  }
}

class _StaticWash extends StatelessWidget {
  final double size;
  final Color color;
  const _StaticWash({required this.size, required this.color});

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

/// A subtle floating animation that drifts the blob slowly
/// for a living-background feel.
class _AnimatedWash extends StatefulWidget {
  final double size;
  final Color color;
  const _AnimatedWash({required this.size, required this.color});

  @override
  State<_AnimatedWash> createState() => _AnimatedWashState();
}

class _AnimatedWashState extends State<_AnimatedWash>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _dx;
  late Animation<double> _dy;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    final seed = widget.size;
    _ctrl = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (6000 + (seed % 4000)).toInt(),
      ),
    );
    _dx = Tween<double>(begin: 0, end: 8 + (seed % 10)).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
    _dy = Tween<double>(begin: 0, end: 6 + (seed % 8)).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.06).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
    _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) => Transform.translate(
        offset: Offset(_dx.value, _dy.value),
        child: Transform.scale(
          scale: _scale.value,
          child: child,
        ),
      ),
      child: _StaticWash(size: widget.size, color: widget.color),
    );
  }
}
