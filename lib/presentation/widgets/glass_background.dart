import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// A warm, premium ambient background with vivid pastel-coloured washes
/// that give real depth behind frosted glass elements.
/// The gradient is deliberately colourful so BackdropFilter in GlassCard
/// has visible content to blur — creating a true frosted look.
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
    final s = MediaQuery.of(context).size;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: dark ? AppColors.walletGradient : AppColors.primaryGradient,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Lavender blob (top-right) ──
          _wash(
            top: s.height * -0.06,
            right: s.width * -0.08,
            size: min(s.width * 1.2, 400),
            color: AppColors.washLavender,
            opacity: 0.55,
          ),
          // ── Peach blob (mid-left) ──
          _wash(
            left: s.width * -0.12,
            top: s.height * 0.20,
            size: min(s.width * 1.0, 340),
            color: AppColors.washPeach,
            opacity: 0.55,
          ),
          // ── Teal blob (bottom-right) ──
          _wash(
            right: s.width * -0.06,
            bottom: s.height * -0.04,
            size: min(s.width * 0.9, 300),
            color: AppColors.washTeal,
            opacity: 0.50,
          ),
          // ── Amber blob (top-left small) ──
          _wash(
            left: s.width * -0.02,
            top: s.height * 0.06,
            size: 160,
            color: AppColors.washAmber,
            opacity: 0.45,
          ),
          // ── Rose blob (mid-right) ──
          _wash(
            right: s.width * 0.06,
            top: s.height * 0.40,
            size: 140,
            color: AppColors.washRose,
            opacity: 0.45,
          ),
          // ── Soft blue wash (bottom-center) ──
          _wash(
            left: s.width * 0.22,
            bottom: s.height * 0.06,
            size: 160,
            color: AppColors.washBlue,
            opacity: 0.45,
          ),
          child,
        ],
      ),
    );
  }

  Widget _wash({
    double? left,
    double? top,
    double? right,
    double? bottom,
    required double size,
    required Color color,
    double opacity = 0.35,
    bool anim = true,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: anim ? _AnimatedWash(size: size, color: color, opacity: opacity)
          : _StaticWash(size: size, color: color, opacity: opacity),
    );
  }
}

class _StaticWash extends StatelessWidget {
  final double size;
  final Color color;
  final double opacity;
  const _StaticWash({required this.size, required this.color, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withValues(alpha: opacity),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _AnimatedWash extends StatefulWidget {
  final double size;
  final Color color;
  final double opacity;
  const _AnimatedWash({required this.size, required this.color, required this.opacity});

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
      duration: Duration(milliseconds: (6000 + (seed % 4000)).toInt()),
    );
    _dx = Tween<double>(begin: 0, end: 10 + (seed % 10)).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
    _dy = Tween<double>(begin: 0, end: 8 + (seed % 8)).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
    _scale = Tween<double>(begin: 1.0, end: 1.08).animate(
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
        child: Transform.scale(scale: _scale.value, child: child),
      ),
      child: _StaticWash(size: widget.size, color: widget.color, opacity: widget.opacity),
    );
  }
}
