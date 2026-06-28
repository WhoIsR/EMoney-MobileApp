import 'dart:ui';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class NumPad extends StatelessWidget {
  final ValueChanged<String> onKey;

  const NumPad({super.key, required this.onKey});

  @override
  Widget build(BuildContext context) {
    final keys = [
      '1', '2', '3',
      '4', '5', '6',
      '7', '8', '9',
      '000', '0', 'del'
    ];
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      children: keys.map((k) {
        Widget child;
        if (k == 'del') {
          child = const Icon(Icons.arrow_back_ios_rounded,
              size: 22, color: AppColors.slate600);
        } else {
          child = Text(
            k,
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontSize: k == '000' ? 20 : 24,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          );
        }
        return GestureDetector(
          onTap: () => onKey(k),
          behavior: HitTestBehavior.opaque,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.glass.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                    width: 0.5,
                  ),
                ),
                child: Center(child: child),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
