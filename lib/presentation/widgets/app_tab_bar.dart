import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppTabBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(22),
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
        children: [
          Expanded(
            child: _navItem(
              index: 0,
              icon: Icons.view_module_rounded,
              label: 'DASH',
              active: currentIndex == 0,
            ),
          ),
          Expanded(
            child: _navItem(
              index: 1,
              icon: Icons.trending_up_rounded,
              label: 'LOGS',
              active: currentIndex == 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () => onTap(4),
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(27),
                  border: Border.all(color: AppColors.black, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black,
                      blurRadius: 0,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 25,
                  color: AppColors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: _navItem(
              index: 2,
              icon: Icons.wallet_rounded,
              label: 'CARD',
              active: currentIndex == 2,
            ),
          ),
          Expanded(
            child: _navItem(
              index: 3,
              icon: Icons.person_rounded,
              label: 'USER',
              active: currentIndex == 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
    required bool active,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: active ? AppColors.purple : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: active ? Border.all(color: AppColors.black, width: 2) : null,
          boxShadow: active
              ? [
                  BoxShadow(
                    color: AppColors.black,
                    blurRadius: 0,
                    offset: const Offset(2, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: active ? AppColors.black : AppColors.white,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: active ? AppColors.black : AppColors.white,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
