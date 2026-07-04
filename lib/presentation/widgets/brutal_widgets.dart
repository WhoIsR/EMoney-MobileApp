import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Neo-brutalism card: colored background, thick black border, hard shadow.
/// Replaces the old GlassCard.
class BrutalCard extends StatelessWidget {
  final Widget child;
  final Color? bgColor;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double shadowOffset;
  final VoidCallback? onTap;

  const BrutalCard({
    super.key,
    required this.child,
    this.bgColor,
    this.borderWidth = AppColors.borderThick,
    this.padding = const EdgeInsets.all(14),
    this.borderRadius = 26,
    this.shadowOffset = 6,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = bgColor ?? AppColors.orange;
    final shadow = BoxShadow(
      color: AppColors.black,
      blurRadius: 0,
      offset: Offset(shadowOffset, shadowOffset),
    );

    Widget card = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppColors.black, width: borderWidth),
        boxShadow: [shadow],
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: card,
      );
    }
    return card;
  }
}

/// Brutalist button: thick border, hard shadow, press effect.
class BrutalButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? bgColor;
  final Color? textColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool isLoading;
  final Widget? icon;
  final double? fontSize;

  const BrutalButton({
    super.key,
    required this.label,
    this.onPressed,
    this.bgColor,
    this.textColor,
    this.height,
    this.width,
    this.padding,
    this.borderRadius = 18,
    this.isLoading = false,
    this.icon,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final bg = bgColor ?? AppColors.orange;
    final fg = textColor ?? AppColors.black;
    final h = height ?? 54.0;
    final fs = fontSize ?? 14.0;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: h,
        width: width ?? double.infinity,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: AppColors.black, width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              blurRadius: 0,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppColors.black,
                ),
              )
            else if (icon != null) ...[
              icon!,
              const SizedBox(width: 8),
            ],
            Text(
              isLoading ? 'Loading...' : label,
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: fs,
                fontWeight: FontWeight.w800,
                color: isLoading ? AppColors.gray500 : fg,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Brutalist status bar (top time + signal)
class BrutalStatusBar extends StatelessWidget {
  const BrutalStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '10:28',
            style: TextStyle(
              fontFamily: 'SpaceGrotesk',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.white.withValues(alpha: 0.9),
              letterSpacing: 1,
            ),
          ),
          Row(
            children: [
              Icon(Icons.signal_cellular_4_bar, size: 14, color: AppColors.green),
              const SizedBox(width: 4),
              Text(
                '5G',
                style: TextStyle(
                  fontFamily: 'SpaceGrotesk',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Brutalist section label (uppercase tracking-wider)
class BrutalLabel extends StatelessWidget {
  final String text;
  final Color? color;
  const BrutalLabel(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontFamily: 'PlusJakartaSans',
        fontSize: 9,
        fontWeight: FontWeight.w900,
        color: color ?? AppColors.gray400,
        letterSpacing: 1.5,
      ),
    );
  }
}

/// Brutalist badge (small tag with bg)
class BrutalBadge extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? textColor;
  const BrutalBadge(this.text, {super.key, this.bgColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.yellow,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.black, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 8,
          fontWeight: FontWeight.w900,
          color: textColor ?? AppColors.black,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
