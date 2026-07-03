import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/feature_icon.dart';
import '../../widgets/brutal_widgets.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final promos = [
      {
        't': 'Cashback 10% di merchant favorit',
        'd': 'Maks. Rp15.000 · s.d. 15 Jul',
        'tone': 'orange',
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
        'tone': 'purple',
        'icon': Icons.receipt_long_outlined
      },
      {
        't': 'Bonus 5.000 poin top up pertama',
        'd': 'Min. Rp50.000',
        'tone': 'yellow',
        'icon': Icons.star_outline_rounded
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          Container(
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
                      color: AppColors.white,
                      letterSpacing: -0.3,
                    )),
                Divider(height: 18, color: AppColors.gray600),
              ],
            ),
          ),
          Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Hero card
              BrutalCard(
                bgColor: AppColors.orange,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.black, width: 2),
                      ),
                      child: const Text('PROMO SPESIAL',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 9,
                            fontWeight: FontWeight.w900,
                            color: AppColors.black,
                            letterSpacing: 1,
                          )),
                    ),
                    const SizedBox(height: 12),
                    const Text('Belanja serba\ndapat cashback',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                          height: 1.2,
                        )),
                    const SizedBox(height: 8),
                    const Text('Kumpulkan cashback tiap transaksi.',
                        style: TextStyle(
                          fontFamily: 'PlusJakartaSans',
                          fontSize: 13.5,
                          color: AppColors.black,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ...promos.map((p) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: BrutalCard(
                    bgColor: AppColors.cardDark,
                    borderRadius: 18,
                    shadowOffset: 4,
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
                                    color: AppColors.white,
                                    height: 1.3,
                                  )),
                              const SizedBox(height: 3),
                              Text(p['d'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 12.5,
                                    color: AppColors.gray400,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ],
    ));
  }
}
