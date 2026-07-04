import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/brutal_widgets.dart';
import '../../widgets/app_badge.dart';
import '../../widgets/feature_icon.dart';

const _twoFaMethods = [
  _TwoFaMethod(
    key: 'totp',
    icon: DkgIcons.smartphone,
    tone: 'violet',
    title: 'Authenticator (TOTP)',
    desc: 'Kode berubah tiap 30 detik di Google Authenticator / Authy.',
    route: '/2fa/totp',
    badge: 'Paling aman',
  ),
  _TwoFaMethod(
    key: 'notif',
    icon: DkgIcons.bell,
    tone: 'green',
    title: 'Notifikasi OTP',
    desc: 'Setujui permintaan masuk lewat notifikasi di HP kamu.',
    route: '/2fa/notif',
  ),
];

class _TwoFaMethod {
  final String key;
  final IconData icon;
  final String tone;
  final String title;
  final String desc;
  final String route;
  final String? badge;
  const _TwoFaMethod({
    required this.key,
    required this.icon,
    required this.tone,
    required this.title,
    required this.desc,
    required this.route,
    this.badge,
  });
}

class Setup2FAPage extends StatefulWidget {
  const Setup2FAPage({super.key});
  @override
  State<Setup2FAPage> createState() => _Setup2FAPageState();
}

class _Setup2FAPageState extends State<Setup2FAPage> {
  String _selected = 'totp';

  Color _cardBg(String tone) => switch (tone) {
        'violet' => AppColors.purple,
        'green' => AppColors.green,
        _ => AppColors.orange,
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(DkgIcons.arrowLeft, color: AppColors.white),
                onPressed: () =>
                    context.canPop() ? context.pop() : context.go('/akun'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 8, 26, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BrutalCard(
                    padding: const EdgeInsets.all(15),
                    borderRadius: 18,
                    bgColor: AppColors.orange,
                    child: Center(
                      child: Icon(DkgIcons.shieldCheck,
                          size: 30, color: AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text('AMANKAN AKUNMU',
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                        letterSpacing: -0.4,
                      )),
                  const SizedBox(height: 7),
                  const Text(
                    'Pilih metode verifikasi 2 langkah (2FA). Kamu bisa ganti kapan saja di Pengaturan.',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 14.5,
                      color: AppColors.gray400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(26, 22, 26, 0),
                children: _twoFaMethods.map((m) {
                  final on = _selected == m.key;
                  return BrutalCard(
                    key: ValueKey(m.key),
                    bgColor: _cardBg(m.tone),
                    borderWidth: on ? 5 : 3,
                    padding: const EdgeInsets.all(15),
                    borderRadius: 18,
                    onTap: () => setState(() => _selected = m.key),
                    child: Row(
                      children: [
                        FeatureIcon(icon: m.icon, tone: m.tone),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(m.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontFamily: 'PlusJakartaSans',
                                          fontSize: 15.5,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.black,
                                        )),
                                  ),
                                  if (m.badge != null) ...[
                                    const SizedBox(width: 7),
                                    AppBadge(label: m.badge!, tone: 'green'),
                                  ],
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(m.desc,
                                  style: const TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 12.8,
                                    color: AppColors.black,
                                    height: 1.45,
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: on ? AppColors.black : Colors.transparent,
                            border: Border.all(
                              color: AppColors.black,
                              width: 2,
                            ),
                          ),
                          child: on
                              ? const Center(
                                  child: Icon(Icons.check,
                                      size: 14, color: AppColors.white),
                                )
                              : null,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(26, 14, 26, 22),
              child: BrutalButton(
                label: 'LANJUTKAN',
                onPressed: () {
                  final m =
                      _twoFaMethods.firstWhere((m) => m.key == _selected);
                  context.go(m.route, extra: {'mode': 'setup'});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
