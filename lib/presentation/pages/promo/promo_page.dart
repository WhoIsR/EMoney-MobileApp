import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/feature_icon.dart';
import '../../widgets/glass_background.dart';
import '../../widgets/glass_card.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final promos = [
      {
        't': 'Cashback 10% di merchant favorit',
        'd': 'Maks. Rp15.000 · s.d. 15 Jul',
        'tone': 'red',
        'icon': Icons.restaurant_outlined
      },
      {
        't': 'Gratis biaya transfer antarbank',
        'd': 'Setiap Jumat · semua bank',
        'tone': 'green',
        'icon': Icons.send_rounded
      },
      {
        't': 'Cicilan 0% 6 bulan minimal belanja',
        'd': 'Syarat & ketentuan berlaku',
        'tone': 'violet',
        'icon': Icons.receipt_long_outlined
      },
      {
        't': 'Bonus 5.000 poin top up pertama',
        'd': 'Min. Rp50.000',
        'tone': 'amber',
        'icon': Icons.star_outline_rounded
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: GlassBackground(
        child: Column(
          children: [
            GlassCard(
              radius: 0,
              color: AppColors.glassStrong,
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).padding.top + 12, 20, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Promo & Reward',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                        letterSpacing: -0.3,
                      )),
                  Divider(height: 18, color: AppColors.line2),
                ],
              ),
            ),
            Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Hero card
                Container(
                  decoration: BoxDecoration(
                    gradient: AppColors.walletGradient,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    boxShadow: AppColors.shadowGlass,
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        right: -40,
                        bottom: -50,
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryLight.withValues(alpha: 0.16),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          AppBadge(label: 'PROMO SPESIAL', tone: 'amber'),
                          SizedBox(height: 12),
                          Text('Belanja serba\ndapat cashback',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ink,
                                height: 1.2,
                              )),
                          SizedBox(height: 8),
                          Text('Kumpulkan cashback tiap transaksi.',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 13.5,
                                color: AppColors.slate500,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                ...promos.map((p) => GlassCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      radius: 18,
                      blur: 0,
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          FeatureIcon(
                              icon: p['icon'] as IconData,
                              tone: p['tone'] as String,
                              size: 50,
                              iconSize: 24),
                          const SizedBox(width: 13),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(p['t'] as String,
                                    style: const TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.ink,
                                      height: 1.3,
                                    )),
                                const SizedBox(height: 3),
                                Text(p['d'] as String,
                                    style: const TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 12.5,
                                      color: AppColors.slate400,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
