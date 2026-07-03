import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Neo-brutalism bottom navbar replicating test.html floating nav.
/// Dark bg, thick black border, hard shadow, colored active tab.
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
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.black, width: 4),
        boxShadow: [
          BoxShadow(
            color: AppColors.black,
            blurRadius: 0,
            offset: const Offset(6, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _navItem(
            index: 0,
            icon: _dashboardIcon(currentIndex == 0),
            label: 'DASH',
            active: currentIndex == 0,
            color: AppColors.purple,
          ),
          _divider(),
          _navItem(
            index: 1,
            icon: _logsIcon(currentIndex == 1),
            label: 'LOGS',
            active: currentIndex == 1,
            color: AppColors.cardDark,
          ),
          const SizedBox(width: 8),
          // Center SCAN button - bigger
          GestureDetector(
            onTap: () => onTap(4), // scan trigger (outside normal tabs)
            child: Container(
              margin: const EdgeInsets.only(top: -12),
              child: Stack(
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      color: AppColors.black,
                    ),
                  ),
                  Positioned(
                    left: 4, top: 4,
                    child: Container(
                      width: 52, height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: AppColors.black, width: 4),
                      ),
                      child: Icon(
                        Icons.qr_code_scanner_rounded,
                        size: 26,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          _divider(),
          _navItem(
            index: 2,
            icon: _cardIcon(currentIndex == 2),
            label: 'CARD',
            active: currentIndex == 2,
            color: AppColors.cardDark,
          ),
          _divider(),
          _navItem(
            index: 3,
            icon: _userIcon(currentIndex == 3),
            label: 'USER',
            active: currentIndex == 3,
            color: AppColors.cardDark,
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required int index,
    required Widget icon,
    required String label,
    required bool active,
    required Color color,
  }) {
    if (active) {
      return GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.black, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.black,
                blurRadius: 0,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: AppColors.black,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: AppColors.white.withValues(alpha: 0.8),
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 3,
      height: 32,
      color: AppColors.black.withValues(alpha: 0.3),
      margin: const EdgeInsets.symmetric(horizontal: 2),
    );
  }

  // ── Icon SVGs in Flutter ──
  Widget _dashboardIcon(bool active) {
    return Icon(
      Icons.view_module_rounded,
      size: 20,
      color: active ? AppColors.black : AppColors.white,
    );
  }

  Widget _logsIcon(bool active) {
    return Icon(
      Icons.trending_up_rounded,
      size: 20,
      color: active ? AppColors.black : AppColors.white,
    );
  }

  Widget _cardIcon(bool active) {
    return Icon(
      Icons.wallet_rounded,
      size: 20,
      color: active ? AppColors.black : AppColors.white,
    );
  }

  Widget _userIcon(bool active) {
    return Icon(
      Icons.person_rounded,
      size: 20,
      color: active ? AppColors.black : AppColors.white,
    );
  }
}
