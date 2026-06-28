import 'dart:ui';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TransactionRow extends StatelessWidget {
  final String icon;
  final String tone;
  final String title;
  final String subtitle;
  final String amount;
  final bool isCredit;
  final bool divider;

  const TransactionRow({
    super.key,
    required this.icon,
    required this.tone,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.isCredit = false,
    this.divider = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconData = _resolveIcon(icon);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.glass.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.10),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                FeatureIcona(icon: iconData, tone: tone, size: 44, iconSize: 21),
                const SizedBox(width: 13),
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
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 12.5,
                          color: AppColors.slate400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${isCredit ? '+' : '-'}$amount',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 14.5,
                    fontWeight: FontWeight.w800,
                    color: isCredit ? AppColors.green : AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ),
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

/// Small icon for inline use in TransactionRow
class FeatureIcona extends StatelessWidget {
  final IconData icon;
  final String tone;
  final double size;
  final double iconSize;

  const FeatureIcona({
    super.key,
    required this.icon,
    this.tone = 'blue',
    this.size = 52,
    this.iconSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.tone(tone);
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.34),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: colors[0].withValues(alpha: 0.80),
            borderRadius: BorderRadius.circular(size * 0.34),
            border: Border.all(
              color: colors[1].withValues(alpha: 0.10),
              width: 0.5,
            ),
          ),
          child: Center(
            child: Icon(icon, color: colors[1], size: iconSize),
          ),
        ),
      ),
    );
  }
}

// Map design icon names to Material icons
class DkgIcons {
  static const IconData home = Icons.home_outlined;
  static const IconData history = Icons.history_rounded;
  static const IconData scan = Icons.qr_code_scanner_rounded;
  static const IconData gift = Icons.card_giftcard_rounded;
  static const IconData user = Icons.person_outline_rounded;
  static const IconData send = Icons.send_rounded;
  static const IconData wallet = Icons.account_balance_wallet_outlined;
  static const IconData plus = Icons.add_rounded;
  static const IconData bell = Icons.notifications_outlined;
  static const IconData eye = Icons.visibility_outlined;
  static const IconData eyeOff = Icons.visibility_off_outlined;
  static const IconData shield = Icons.shield_outlined;
  static const IconData shieldCheck = Icons.verified_user_outlined;
  static const IconData check = Icons.check_rounded;
  static const IconData mail = Icons.mail_outline_rounded;
  static const IconData lock = Icons.lock_outline_rounded;
  static const IconData phone = Icons.phone_outlined;
  static const IconData copy = Icons.copy_rounded;
  static const IconData bank = Icons.account_balance_outlined;
  static const IconData arrowLeft = Icons.arrow_back_ios_new_rounded;
  static const IconData arrowRight = Icons.arrow_forward_ios_rounded;
  static const IconData chevRight = Icons.chevron_right_rounded;
  static const IconData chevDown = Icons.keyboard_arrow_down_rounded;
  static const IconData topup = Icons.north_rounded;
  static const IconData bill = Icons.receipt_outlined;
  static const IconData pulsa = Icons.smartphone_outlined;
  static const IconData more = Icons.more_horiz_rounded;
  static const IconData close = Icons.close_rounded;
  static const IconData search = Icons.search_rounded;
  static const IconData fingerprint = Icons.fingerprint_rounded;
  static const IconData key = Icons.key_outlined;
  static const IconData xcircle = Icons.cancel_outlined;
  static const IconData info = Icons.info_outline_rounded;
  static const IconData qris = Icons.qr_code_rounded;
  static const IconData store = Icons.storefront_outlined;
  static const IconData link = Icons.link_rounded;
  static const IconData clock = Icons.access_time_rounded;
  static const IconData refresh = Icons.refresh_rounded;
  static const IconData settings = Icons.settings_outlined;
  static const IconData logout = Icons.logout_rounded;
  static const IconData star = Icons.star_outline_rounded;
  static const IconData splitBill = Icons.receipt_long_outlined;
  static const IconData card = Icons.credit_card_outlined;
  static const IconData food = Icons.restaurant_outlined;
  static const IconData smartphone = Icons.smartphone_rounded;
}
