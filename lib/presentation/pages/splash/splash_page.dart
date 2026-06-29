import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/deeplink_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/app_button.dart';
import '../../widgets/glass_background.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/feature_icon.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          final pending = DeeplinkService.consumePending();
          if (pending != null) {
            context.go('/pay', extra: pending);
          } else {
            context.go('/home');
          }
        } else if (state is AuthNeedsVerification) {
          context.go('/2fa/totp', extra: {
            'mode': state.user.totpEnabled ? 'login' : 'setup',
          });
        }
      },
      child: Scaffold(
        body: GlassBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  // Logo branding
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: AppLogo(size: 44, withText: true),
                  ),
                  const SizedBox(height: 36),
                  // Title
                  const Text(
                    'Dompet Digital\nE-Money',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: AppColors.ink,
                      letterSpacing: -1.2,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 36),
                  
                  // Key Benefits List
                  _buildBenefitRow(
                    icon: Icons.bolt_rounded,
                    tone: 'blue',
                    title: 'Transaksi Instan',
                    desc: 'Kirim uang dan bayar tagihan dalam hitungan detik.',
                  ),
                  const SizedBox(height: 24),
                  _buildBenefitRow(
                    icon: Icons.qr_code_scanner_rounded,
                    tone: 'green',
                    title: 'QRIS Universal',
                    desc: 'Pindai kode QR merchant apa pun untuk transaksi cepat.',
                  ),
                  const SizedBox(height: 24),
                  _buildBenefitRow(
                    icon: Icons.security_rounded,
                    tone: 'violet',
                    title: 'Keamanan Kuat',
                    desc: 'Proteksi keamanan berlapis dengan 2FA dan notifikasi.',
                  ),
                  
                  const Spacer(),
                  // Action buttons
                  AppButton(
                    label: 'Buat Akun Baru',
                    onPressed: () => context.push('/register'),
                  ),
                  const SizedBox(height: 12),
                  AppButton(
                    label: 'Masuk ke Akun',
                    variant: AppButtonVariant.outline,
                    onPressed: () => context.push('/login'),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitRow({
    required IconData icon,
    required String tone,
    required String title,
    required String desc,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FeatureIcon(
          icon: icon,
          tone: tone,
          size: 46,
          iconSize: 22,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 15.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 13.5,
                  color: AppColors.slate500,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
