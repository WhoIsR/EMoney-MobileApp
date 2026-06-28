import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../blocs/account/account_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/app_avatar.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/feature_icon.dart';
import '../../widgets/glass_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/transaction_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _hideBalance = false;

  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(AccountLoadRequested());
    context.read<AuthBloc>().add(AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassBackground(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            final user = authState is AuthAuthenticated ? authState.user : null;
            final firstName = user?.firstName ?? 'Kamu';
            final fullName = user?.name ?? 'User';

            return BlocBuilder<AccountBloc, AccountState>(
              builder: (context, accountState) {
                final balance = accountState is AccountLoaded
                    ? accountState.account.balance
                    : 0.0;
                final txns = accountState is AccountLoaded
                    ? accountState.transactions
                    : <TransactionEntity>[];
                final loading = accountState is AccountLoading;

                return RefreshIndicator(
                  onRefresh: () async => context
                      .read<AccountBloc>()
                      .add(AccountRefreshRequested()),
                  color: AppColors.accent,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top + 10),
                        // ── Header ──
                        _buildHeader(firstName, fullName),
                        // ── Balance Card ──
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildBalanceCard(balance, loading),
                        ),
                        const SizedBox(height: 22),
                        // ── Points row ──
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildPointsRow(),
                        ),
                        const SizedBox(height: 20),
                        // ── Feature grid ──
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildFeatureGrid(),
                        ),
                        const SizedBox(height: 20),
                        // ── Deeplink banner ──
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildDeeplinkBanner(),
                        ),
                        const SizedBox(height: 24),
                        // ── Transactions ──
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildTransactions(txns),
                        ),
                        const SizedBox(height: 120), // room for floating navbar
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // ── Header ──
  Widget _buildHeader(String firstName, String fullName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 50),
      child: Row(
        children: [
          // Avatar
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AppAvatar(
              name: fullName,
              size: 44,
              bg: Colors.white.withValues(alpha: 0.84),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_timeGreeting(),
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 12.5,
                      color: AppColors.slate500,
                    )),
                Text(firstName,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                      letterSpacing: -0.2,
                    )),
              ],
            ),
          ),
          // Notification bell
          Stack(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.glassFill,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.glassStroke),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.notifications_outlined,
                    size: 20, color: AppColors.primaryDark),
              ),
              Positioned(
                top: 10,
                right: 11,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.amber,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.amber.withValues(alpha: 0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Balance Card (iOS Wallet double-bezel style) ──
  Widget _buildBalanceCard(double balance, bool loading) {
    final actions = [
      {'icon': Icons.north_rounded, 'label': 'Top Up', 'route': '/topup'},
      {'icon': Icons.send_rounded, 'label': 'Transfer', 'route': '/transfer'},
      {'icon': Icons.qr_code_rounded, 'label': 'Bayar', 'route': '/payment'},
      {'icon': Icons.south_rounded, 'label': 'Tarik', 'route': '/topup'},
    ];

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1.1,
        ),
        boxShadow: AppColors.shadowGlass,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.walletGradient,
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.16),
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
          child: Column(
            children: [
              // ── Label row ──
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const AppLogo(size: 20),
                  ),
                  const SizedBox(width: 8),
                  const Text('Saldo Kashi',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Colors.white70,
                      )),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.go('/topup'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.95)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.add_rounded,
                              size: 14, color: AppColors.primary),
                          SizedBox(width: 4),
                          Text('Isi Saldo',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                                fontSize: 12.0,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // ── Amount ──
              Row(
                children: [
                  Text(
                    _hideBalance
                        ? CurrencyFormatter.maskBalance()
                        : CurrencyFormatter.format(balance),
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                        _hideBalance
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: Colors.white60),
                    onPressed: () =>
                        setState(() => _hideBalance = !_hideBalance),
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              // ── Action buttons ──
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.12)),
                  ),
                ),
                child: Row(
                  children: actions.map((a) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => context.go(a['route'] as String),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: [
                              FeatureIcon(
                                icon: a['icon'] as IconData,
                                tone: 'glass',
                                size: 44,
                                iconSize: 20,
                              ),
                              const SizedBox(height: 6),
                              Text(a['label'] as String,
                                  style: const TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white70,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Points row ──
  Widget _buildPointsRow() {
    return SizedBox(
      height: 64,
      child: Row(
        children: [
          Expanded(
            child: GlassCard(
              radius: 18,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              child: Row(
                children: [
                  const FeatureIcon(
                      icon: Icons.star_outline_rounded,
                      tone: 'amber',
                      size: 38,
                      iconSize: 19),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Reward Poin',
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 11.5,
                              color: AppColors.slate500,
                              fontWeight: FontWeight.w600)),
                      Text('1.250',
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.ink)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: GlassCard(
              radius: 18,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
              child: Row(
                children: [
                  const FeatureIcon(
                      icon: Icons.qr_code_rounded,
                      tone: 'green',
                      size: 38,
                      iconSize: 19),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('QR Instan',
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 11.5,
                              color: AppColors.slate500,
                              fontWeight: FontWeight.w600)),
                      Text('Aktif',
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.ink)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Feature grid (4 columns, perfectly centered) ──
  Widget _buildFeatureGrid() {
    final features = [
      {'icon': Icons.smartphone_outlined, 'label': 'Pulsa', 'tone': 'blue'},
      {'icon': Icons.bolt_outlined, 'label': 'PLN', 'tone': 'amber'},
      {'icon': Icons.restaurant_outlined, 'label': 'Makanan', 'tone': 'red'},
      {'icon': Icons.receipt_long_outlined, 'label': 'Tagihan', 'tone': 'violet'},
      {'icon': Icons.wifi_rounded, 'label': 'Paket Data', 'tone': 'green'},
      {'icon': Icons.card_giftcard_rounded, 'label': 'Voucher', 'tone': 'red'},
      {'icon': Icons.favorite_outline_rounded, 'label': 'Donasi', 'tone': 'amber'},
      {'icon': Icons.more_horiz_rounded, 'label': 'Lainnya', 'tone': 'slate'},
    ];
    final screenWidth = MediaQuery.of(context).size.width;
    final availableWidth = screenWidth - 32; // 16px padding each side
    // 4 columns: 3 gaps of 10px each
    final itemWidth = (availableWidth - 30) / 4;

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: features.map((f) {
        return SizedBox(
          width: itemWidth,
          child: GlassCard(
            radius: 20,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 0),
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FeatureIcon(
                    icon: f['icon'] as IconData,
                    tone: f['tone'] as String,
                    size: 44,
                    iconSize: 22),
                const SizedBox(height: 7),
                Text(f['label'] as String,
                    style: const TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.slate600,
                    )),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Deeplink banner ──
  Widget _buildDeeplinkBanner() {
    return GestureDetector(
      onTap: () => context.go('/merchant'),
      child: GlassCard(
        radius: 22,
        padding: EdgeInsets.zero,
        color: Colors.white.withValues(alpha: 0.72),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.84),
                AppColors.washLavender.withValues(alpha: 0.32),
                AppColors.washPeach.withValues(alpha: 0.24),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: -30,
                top: -40,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryLight.withValues(alpha: 0.22),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.glassStroke),
                    ),
                    child: const Icon(Icons.link_rounded,
                        size: 24, color: AppColors.primary),
                  ),
                  const SizedBox(width: 13),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Coba bayar dari toko online',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.ink,
                            )),
                        SizedBox(height: 2),
                        Text('Simulasi checkout e-commerce → bayar via Kashi',
                            style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontSize: 12.5,
                              color: AppColors.slate500,
                            )),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded,
                      size: 20, color: AppColors.slate500),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Transaction list ──
  Widget _buildTransactions(List<TransactionEntity> txns) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Transaksi terakhir',
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                )),
            GestureDetector(
              onTap: () => context.go('/history'),
              child: const Text('Lihat semua',
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 13),
        GlassCard(
          radius: 22,
          padding: EdgeInsets.zero,
          child: txns.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text('Belum ada transaksi',
                        style: TextStyle(
                            color: AppColors.slate400,
                            fontFamily: 'PlusJakartaSans')),
                  ),
                )
              : Column(
                  children: txns
                      .take(4)
                      .toList()
                      .asMap()
                      .entries
                      .map((e) => TransactionRow(
                            icon: e.value.isCredit ? 'topup' : 'send',
                            tone: e.value.isCredit ? 'green' : 'blue',
                            title: e.value.description.isEmpty
                                ? (e.value.isCredit ? 'Top Up' : 'Transaksi')
                                : e.value.description,
                            subtitle:
                                '${e.value.createdAt.day}/${e.value.createdAt.month}/${e.value.createdAt.year}',
                            amount: CurrencyFormatter.format(e.value.amount),
                            isCredit: e.value.isCredit,
                            divider: e.key > 0,
                          ))
                      .toList(),
                ),
        ),
      ],
    );
  }

  String _timeGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 11) return 'Selamat pagi,';
    if (hour < 15) return 'Selamat siang,';
    if (hour < 18) return 'Selamat sore,';
    return 'Selamat malam,';
  }
}
