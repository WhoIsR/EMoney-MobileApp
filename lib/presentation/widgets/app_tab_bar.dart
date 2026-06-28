import 'dart:ui';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Apple-style floating glass tab bar with a raised scan button.
/// Detached from bottom edge — sits as a floating pill with premium glass.
class AppTabBar extends StatefulWidget {
  final String active;
  final ValueChanged<String> onTab;
  final VoidCallback? onScan;

  const AppTabBar({
    super.key,
    required this.active,
    required this.onTab,
    this.onScan,
  });

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar>
    with SingleTickerProviderStateMixin {
  final List<_TabDef> _tabs = const [
    _TabDef(
        icon: Icons.home_rounded,
        iconFilled: Icons.home_rounded,
        label: 'Home',
        tabKey: 'home'),
    _TabDef(
        icon: Icons.history_rounded,
        iconFilled: Icons.history_rounded,
        label: 'Riwayat',
        tabKey: 'history'),
    _TabDef(
        icon: Icons.card_giftcard_rounded,
        iconFilled: Icons.card_giftcard_rounded,
        label: 'Promo',
        tabKey: 'promo'),
    _TabDef(
        icon: Icons.person_outline_rounded,
        iconFilled: Icons.person_rounded,
        label: 'Akun',
        tabKey: 'akun'),
  ];

  int get _activeIndex =>
      _tabs.indexWhere((t) => t.tabKey == widget.active).clamp(0, 3);

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final activeIdx = _activeIndex;

    return Container(
      height: 74 + bottomPad,
      padding: EdgeInsets.only(bottom: bottomPad > 0 ? 0 : 6),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // ── Floating glass pill ──
          ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
              child: Container(
                height: 64,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.glassStrong.withValues(alpha: 0.86),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.86),
                    width: 1.1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.38),
                      blurRadius: 12,
                      offset: const Offset(0, -2),
                    ),
                    // Subtle inner light from top
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.30),
                      blurRadius: 8,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Left tabs (home, history)
                    ..._tabs.sublist(0, 2).map(
                          (tab) => _buildTabItem(tab, activeIdx),
                        ),
                    // ── Center scan button ──
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.onScan,
                        child: Transform.translate(
                          offset: const Offset(0, -14),
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: AppColors.liquidGradient,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.25),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.28),
                                  blurRadius: 16,
                                  offset: const Offset(0, 6),
                                ),
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.14),
                                  blurRadius: 28,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.qr_code_scanner_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Right tabs (promo, akun)
                    ..._tabs.sublist(2).map(
                          (tab) => _buildTabItem(tab, activeIdx),
                        ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(_TabDef tab, int activeIdx) {
    final idx = _tabs.indexOf(tab);
    final isActive = idx == activeIdx;

    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTab(tab.tabKey),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.only(top: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Icon + active pill background ──
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                width: isActive ? 42 : 28,
                height: isActive ? 42 : 28,
                decoration: BoxDecoration(
                  gradient: isActive ? AppColors.liquidGradient : null,
                  color: isActive ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(isActive ? 13 : 8),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.18),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  isActive ? tab.iconFilled : tab.icon,
                  size: 18,
                  color: isActive ? Colors.white : AppColors.slate500,
                ),
              ),
              const SizedBox(height: 3),
              // ── Label ──
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 9.5,
                  fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  color: isActive ? AppColors.primaryDark : AppColors.slate500,
                  letterSpacing: isActive ? 0.1 : 0,
                ),
                child: Text(tab.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabDef {
  final IconData icon;
  final IconData iconFilled;
  final String label;
  final String tabKey;

  const _TabDef({
    required this.icon,
    required this.iconFilled,
    required this.label,
    required this.tabKey,
  });
}
