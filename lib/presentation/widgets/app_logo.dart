import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool light;
  final bool withText;

  const AppLogo(
      {super.key, this.size = 56, this.light = false, this.withText = false});

  @override
  Widget build(BuildContext context) {
    const fontFamily = 'PlusJakartaSans';

    // Wrap icon in glass effect
    Widget icon = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: light
            ? Colors.white.withValues(alpha: 0.12)
            : AppColors.glass.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(size * 0.28),
        border: Border.all(
          color: light
              ? Colors.white.withValues(alpha: 0.20)
              : AppColors.glassLine,
          width: 0.5,
        ),
      ),
      child: Image.asset(
        'assets/images/logo-dompet.png',
        width: size * 0.7,
        height: size * 0.7,
        fit: BoxFit.contain,
      ),
    );

    if (!withText) return icon;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kashi',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: size * 0.3,
                fontWeight: FontWeight.w800,
                color: light ? Colors.white : AppColors.ink,
                letterSpacing: -0.3,
                height: 1.05,
              ),
            ),
            Text(
              'e-money',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: size * 0.205,
                fontWeight: FontWeight.w700,
                color: light
                    ? Colors.white.withValues(alpha: 0.85)
                    : AppColors.primary,
                letterSpacing: 1.5,
                height: 1.05,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
