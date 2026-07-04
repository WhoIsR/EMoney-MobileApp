import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'feature_icon.dart';

/// Brutalist transaction row with icon, title/subtitle, amount, and chevron.
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
    final amountColor = isCredit ? AppColors.green : AppColors.orange;
    final sign = isCredit ? '+' : '';

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (divider)
            Padding(
              padding: const EdgeInsets.only(left: 68, right: 16),
              child: Container(height: 1, color: AppColors.gray600),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(
              children: [
                FeatureIcon(icon: iconData, tone: tone, size: 40, iconSize: 19),
                const SizedBox(width: 12),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 12,
                          color: AppColors.gray400,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$sign$amount',
                  style: TextStyle(
                    fontFamily: 'SpaceGrotesk',
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: amountColor,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.gray500),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _resolveIcon(String name) {
    switch (name) {
      case 'topup': return DkgIcons.topup;
      case 'send': return DkgIcons.send;
      case 'qris': return DkgIcons.qris;
      case 'pulsa': return DkgIcons.pulsa;
      case 'store': return DkgIcons.store;
      case 'wallet':
      default: return DkgIcons.wallet;
    }
  }
}
