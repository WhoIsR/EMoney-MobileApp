import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../widgets/brutal_widgets.dart';
import '../../widgets/feature_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable content ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                child: Column(
                  children: [
                    // ── Profile Header (like test.html) ──
                    _buildProfileHeader(),
                    const SizedBox(height: 12),

                    // ── Notification Banner ──
                    _buildNotificationBanner(),
                    const SizedBox(height: 14),

                    // ── Balance Card (ORANGE - like test.html) ──
                    _buildBalanceCard(),
                    const SizedBox(height: 14),

                    // ── Bento Grid: Expense + Categories ──
                    _buildBentoGrid(),
                    const SizedBox(height: 14),

                    // ── Bank Wallet + Live Timer Row ──
                    _buildBottomRow(),
                    const SizedBox(height: 20),

                    // ── Quick Actions ──
                    _buildQuickActions(),
                    const SizedBox(height: 8),

                    // ── Recent Transactions ──
                    _buildRecentTransactions(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // ── Profile Header ──
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.black, width: 3),
        boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(4, 4))],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: AppColors.yellow,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.black, width: 2),
              boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(2, 2))],
            ),
            child: const Icon(Icons.person, size: 20, color: AppColors.black),
          ),
          const SizedBox(width: 10),
          // Name + label
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'E-MONEY OPERATOR',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 9,
                  fontWeight: FontWeight.w900,
                  color: AppColors.gray400,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'Hi, Radja Satrio!',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: AppColors.white,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const Spacer(),
          // Search + Bell icons
          _iconBox(
            AppColors.white,
            Icons.search,
            AppColors.yellow,
            () => _showSearchHint(context),
          ),
          const SizedBox(width: 8),
          _iconBox(
            AppColors.orange,
            Icons.notifications,
            AppColors.black,
            () => _showNotifications(context),
          ),
        ],
      ),
    );
  }

  Widget _iconBox(
    Color bg,
    IconData icon,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32, height: 32,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.black, width: 2),
          boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(2, 2))],
        ),
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }

  void _showSearchHint(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pencarian transaksi segera hadir')),
    );
  }

  void _showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrutalLabel('NOTIFIKASI'),
              const SizedBox(height: 14),
              _notificationTile(
                Icons.verified_user_rounded,
                'Limit transaksi aman',
                'Batas harian masih tersedia untuk pembayaran dan transfer.',
              ),
              const SizedBox(height: 10),
              _notificationTile(
                Icons.receipt_long_rounded,
                'Cek riwayat terbaru',
                'Pantau transaksi terakhir sebelum melakukan pembayaran.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationTile(IconData icon, String title, String subtitle) {
    return BrutalCard(
      bgColor: AppColors.white,
      borderRadius: 16,
      padding: const EdgeInsets.all(12),
      shadowOffset: 3,
      child: Row(
        children: [
          Icon(icon, size: 22, color: AppColors.black),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w900, color: AppColors.black)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.gray600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Notification Banner ──
  Widget _buildNotificationBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.black, width: 3),
        boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(4, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.yellow,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.black, width: 2),
            ),
            child: const Icon(Icons.campaign_rounded, size: 16, color: AppColors.black),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BrutalBadge('ALERT NOTIFICATION'),
                SizedBox(height: 4),
                Text(
                  'Approve your dynamic limits and check recent transactions right now.',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Balance Card (ORANGE like test.html) ──
  Widget _buildBalanceCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.orange,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.black, width: 4),
        boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(6, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrutalLabel('TOTAL BALANCE', color: AppColors.black),
                  SizedBox(height: 6),
                  Text(
                    'Rp156.900.67',
                    style: TextStyle(
                      fontFamily: 'SpaceGrotesk',
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: AppColors.black,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.black),
                  boxShadow: [BoxShadow(color: AppColors.white, blurRadius: 0, offset: const Offset(1, 1))],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, size: 12, color: AppColors.green),
                    SizedBox(width: 4),
                    Text(
                      'AKTIF',
                      style: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 9, fontWeight: FontWeight.w900, color: AppColors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.bg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.black, width: 2),
              boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(2, 2))],
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.account_balance_wallet_rounded, size: 12, color: AppColors.orange),
                SizedBox(width: 6),
                Text(
                  'KASHI WALLET',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _balanceAction(Icons.add_rounded, 'Top Up', AppColors.yellow, () => context.go('/topup')),
              _balanceAction(Icons.send_rounded, 'Transfer', AppColors.green, () => context.go('/transfer')),
              _balanceAction(Icons.qr_code_scanner_rounded, 'Scan', AppColors.purple, () => context.go('/payment')),
              _balanceAction(Icons.receipt_long_rounded, 'Bayar', AppColors.white, () => context.go('/payment')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _balanceAction(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 46, height: 46,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.black, width: 2),
                boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(2, 2))],
              ),
              child: Icon(icon, size: 22, color: AppColors.black),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Bento Grid: Expense + Categories ──
  Widget _buildBentoGrid() {
    return Row(
      children: [
        // Expense Capacity (purple)
        Expanded(
          child: Container(
            height: 175,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.black, width: 4),
              boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(5, 5))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BrutalLabel('EXPENSE CAPACITY', color: AppColors.black),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: AppColors.black, width: 1),
                        boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(1, 1))],
                      ),
                      child: const Text('75%', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8, fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('LIMIT', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.white)),
                    ),
                  ],
                ),
                const Spacer(),
                // Wave SVG-like visual
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.black, width: 2),
                  ),
                  child: CustomPaint(
                    painter: _WavePainter(),
                    size: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        // Categories (yellow)
        Expanded(
          child: Container(
            height: 175,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.yellow,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.black, width: 4),
              boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(5, 5))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.black, width: 1.5),
                  ),
                  child: const Text('CATEGORIES', style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8, fontWeight: FontWeight.w900)),
                ),
                const SizedBox(height: 8),
                const Text(
                  'QUICK ACTIONS',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 12, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                _categoryRow(AppColors.black, 'Food & Bistro'),
                const SizedBox(height: 4),
                _categoryRow(AppColors.black, 'Scan Barcode'),
                const Spacer(),
                // Data stack box
                Container(
                  height: 40,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.black, width: 2),
                    boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(3, 3))],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.stacked_line_chart_rounded, size: 18, color: AppColors.black),
                      const SizedBox(width: 4),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.black),
                          children: [
                            TextSpan(text: 'DATA\n'),
                            TextSpan(text: 'STACK', style: TextStyle(color: AppColors.orange)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _categoryRow(Color dotColor, String label) {
    return Row(
      children: [
        Container(width: 6, height: 6, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8, fontWeight: FontWeight.w700)),
      ],
    );
  }

  // ── Bottom Row: Bank Wallet + Live Timer ──
  Widget _buildBottomRow() {
    return Row(
      children: [
        // Bank Wallet (dark card, 7 cols)
        Expanded(
          flex: 7,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.black, width: 4),
              boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(5, 5))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: BrutalLabel('BANK WALLET'),
                ),
                const SizedBox(height: 8),
                _bankRow(AppColors.orange, Icons.business, 'MANDIRI', true),
                const SizedBox(height: 4),
                _bankRow(AppColors.white, Icons.circle_outlined, 'BCA LINK', false),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        // Live Timer (white, 5 cols)
        Expanded(
          flex: 5,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.black, width: 4),
              boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(5, 5))],
            ),
            child: Column(
              children: [
                const Text(
                  'LIVE TIMER',
                  style: TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 8, fontWeight: FontWeight.w900, letterSpacing: 1),
                ),
                const SizedBox(height: 8),
                // Clock face
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.black, width: 4),
                    color: AppColors.gray50,
                  ),
                  child: CustomPaint(
                    painter: _ClockPainter(),
                    size: const Size(48, 48),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [BoxShadow(color: AppColors.white.withValues(alpha: 0.4), blurRadius: 0, offset: const Offset(1, 1))],
                  ),
                  child: const Text(
                    '12:47:33',
                    style: TextStyle(fontFamily: 'SpaceGrotesk', fontSize: 8, fontWeight: FontWeight.w900, color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _bankRow(Color bg, IconData icon, String name, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.black, width: 2),
        boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(2, 2))],
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: active ? AppColors.white : AppColors.black),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontFamily: 'SpaceGrotesk',
                fontSize: 9,
                fontWeight: FontWeight.w900,
                color: active ? AppColors.black : AppColors.black,
              ),
            ),
          ),
          Container(
            width: 8, height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.green,
              border: Border.all(color: AppColors.black, width: 1),
            ),
          ),
        ],
      ),
    );
  }

  // ── Quick Actions ──
  Widget _buildQuickActions() {
    final actions = [
      (Icons.add_rounded, 'Top Up', 'orange'),
      (Icons.send_rounded, 'Transfer', 'green'),
      (Icons.qr_code_scanner_rounded, 'Scan QR', 'purple'),
      (Icons.receipt_outlined, 'Bayar', 'blue'),
      (Icons.smartphone_outlined, 'Pulsa', 'pink'),
      (Icons.more_horiz_rounded, 'Lainnya', 'dark'),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BrutalLabel('QUICK ACTIONS'),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: actions.map((a) {
            return GestureDetector(
              onTap: () {
                switch (a.$2) {
                  case 'Top Up': context.go('/topup');
                  case 'Transfer': context.go('/transfer');
                  case 'Scan QR': context.go('/payment');
                  case 'Bayar': context.go('/payment');
                  case 'Pulsa': ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fitur Pulsa segera hadir')));
                  case 'Lainnya': _showMoreSheet(context);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FeatureIcon(icon: a.$1, tone: a.$3, size: 52, iconSize: 24),
                  const SizedBox(height: 4),
                  Text(
                    a.$2,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: AppColors.gray400,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _showMoreSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: AppColors.gray600,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              BrutalLabel('FITUR LAINNYA'),
              const SizedBox(height: 16),
              BrutalButton(
                label: 'Riwayat Transaksi',
                onPressed: () { Navigator.pop(context); context.go('/history'); },
                bgColor: AppColors.purple,
              ),
              const SizedBox(height: 10),
              BrutalButton(
                label: 'Pengaturan Akun',
                onPressed: () { Navigator.pop(context); context.go('/account'); },
                bgColor: AppColors.yellow,
              ),
              const SizedBox(height: 10),
              BrutalButton(
                label: 'Promo & Diskon',
                onPressed: () { Navigator.pop(context); context.go('/promo'); },
                bgColor: AppColors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Recent Transactions ──
  Widget _buildRecentTransactions() {
    final items = [
      ('topup', 'green', 'Top Up Mandiri', '23 Jun 2025', 'Rp50.000', true),
      ('send', 'orange', 'Transfer ke Budi', '23 Jun 2025', 'Rp25.000', false),
      ('store', 'purple', 'Alfamart', '22 Jun 2025', 'Rp15.750', false),
      ('qris', 'blue', 'QRIS - Kopi Senja', '22 Jun 2025', 'Rp12.000', false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BrutalLabel('RECENT TRANSACTIONS'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: AppColors.black, width: 4),
            boxShadow: [BoxShadow(color: AppColors.black, blurRadius: 0, offset: const Offset(5, 5))],
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              final i = e.key;
              final t = e.value;
              return Column(
                children: [
                  if (i > 0) const Divider(height: 1, indent: 64, color: AppColors.gray600),
                  ListTile(
                    leading: FeatureIcon(icon: _resolveIcon(t.$1), tone: t.$2, size: 40, iconSize: 18),
                    title: Text(t.$3, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.white)),
                    subtitle: Text(t.$4, style: const TextStyle(fontFamily: 'PlusJakartaSans', fontSize: 11, color: AppColors.gray400)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(t.$5, style: TextStyle(
                          fontFamily: 'SpaceGrotesk',
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: t.$6 ? AppColors.green : AppColors.orange,
                        )),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right_rounded, size: 16, color: AppColors.gray500),
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  IconData _resolveIcon(String name) {
    switch (name) {
      case 'topup': return Icons.north_rounded;
      case 'send': return Icons.send_rounded;
      case 'qris': return Icons.qr_code_rounded;
      case 'store': return Icons.storefront_outlined;
      case 'pulsa': return Icons.smartphone_outlined;
      default: return Icons.account_balance_wallet_outlined;
    }
  }
}

// ── Custom Painters ──
class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(0, size.height * 0.6)
      ..cubicTo(size.width * 0.3, size.height * 0.2, size.width * 0.5, size.height * 0.8, size.width, size.height * 0.3)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);

    final dotPaint = Paint()..color = AppColors.black;
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.32), 3, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = AppColors.black
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    // Hour hand
    canvas.drawLine(c, Offset(c.dx, c.dy - 12), paint);
    // Minute hand
    paint.strokeWidth = 1.5;
    canvas.drawLine(c, Offset(c.dx + 8, c.dy - 6), paint);
    // Center dot
    canvas.drawCircle(c, 3, Paint()..color = AppColors.orange);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
