import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'feature_icon.dart';

/// A transaction row with clear visual hierarchy: icon → title/subtitle → amount → chevron.
/// Designed to sit inside a parent GlassCard (no redundant glass per item).
class TransactionRow extends StatelessWidget {
  final String icon;
  final String tone;
  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;
  final bool divider;
  final VoidCallback? onTap;

  const TransactionRow({
    super.key,
    required this.icon,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.isCredit = false,
    this.divider = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = _resolveIcon(icon);
    final amountColor = isCredit ? AppColors.green : AppColors.ink;
    final sign = isCredit ? '+' : '';

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Divider ──
          if (divider)
            Padding(
              padding: const EdgeInsets.only(left: 68, right: 16),
              child: Divider(
                height: 0.5,
                thickness: 0.5,
                color: AppColors.line2,
              ),
            ),
          // ── Row ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Icon
                FeatureIcon(
                    icon: iconData, tone: tone, size: 44, iconSize: 21),
                const SizedBox(width: 13),
                // Title + subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 12.5,
                          color: AppColors.slate400,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Amount
                Text(
                  '$sign$amount',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: amountColor,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(width: 6),
                // Chevron
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: AppColors.slate300,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _resolveIcon(String name) {
    switch (name) {
      case 'topup':
        return DkgIcons.topup;
      case 'send':
        return DkgIcons.send;
      case 'qris':
        return DkgIcons.qris;
      case 'pulsa':
        return DkgIcons.pulsa;
      case 'store':
        return DkgIcons.store;
      case 'wallet':
      default:
        return DkgIcons.wallet;
    }
  }
}
