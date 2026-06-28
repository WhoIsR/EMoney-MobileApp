import 'dart:ui';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Apple-style floating glass tab bar with an unclipped raised scan button.
/// The scan button sits completely outside the glass pill — no clipping.
/// This widget returns ONLY the pill + scan button, no extra spacing.
/// Positioning is handled by the parent Stack in app_router.dart.
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
  static const _pillHeight = 58.0;
  static const _pillMarginH = 20.0; // horizontal margin on each side
  static const _scanButtonOffset = -22.0;

  int get _activeIndex {
    switch (widget.active) {
      case 'home':    return 0;
      case 'history': return 1;
      case 'promo':   return 2;
      case 'akun':    return 3;
      default:        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPad + 10),
      child: SizedBox(
        height: _pillHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── The floating glass pill ──
            Positioned(
              left: _pillMarginH,
              right: _pillMarginH,
              top: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xC8F5F3FA), // ~78% translucent
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.85),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 30,
                          offset: const Offset(0, 12),
                        ),
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.04),
                          blurRadius: 50,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: _TabRow(activeIndex: _activeIndex, onTab: widget.onTab),
                  ),
                ),
              ),
            ),

            // ── Raised scan button ──
            Positioned(
              top: _scanButtonOffset,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: widget.onScan,
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF6B6FFF), Color(0xFF3B3DFF)],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
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
          ],
        ),
      ),
    );
  }
}

/// The tab row inside the glass pill with a sliding indicator.
class _TabRow extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<String> onTab;

  const _TabRow({required this.activeIndex, required this.onTab});

  static const _tabs = [
    _TabItem('home',  Icons.home_rounded,      'Home'),
    _TabItem('history', Icons.history_rounded,  'Riwayat'),
    _TabItem('promo',   Icons.card_giftcard_rounded, 'Promo'),
    _TabItem('akun',    Icons.person_outline_rounded, 'Akun'),
  ];

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width - 40;
    final slotWidth = totalWidth / 4;
    final left = activeIndex * slotWidth;

    return Stack(
      children: [
        // ── Sliding active indicator ──
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          left: left + 8,
          top: 7,
          bottom: 7,
          width: slotWidth - 16,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
          ),
        ),

        // ── Tab items ──
        Row(
          children: List.generate(_tabs.length, (i) {
            final tab = _tabs[i];
            final active = i == activeIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTab(tab.key),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tab.icon,
                      size: 20,
                      color: active
                          ? AppColors.primary
                          : AppColors.slate400,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      tab.label,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 9.5,
                        fontWeight:
                            active ? FontWeight.w800 : FontWeight.w500,
                        color: active
                            ? AppColors.primary
                            : AppColors.slate500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _TabItem {
  final String key;
  final IconData icon;
  final String label;
  const _TabItem(this.key, this.icon, this.label);
}
