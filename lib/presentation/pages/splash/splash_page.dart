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
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                children: [
                  const Spacer(),
                  GlassCard(
                    radius: 34,
                    padding: const EdgeInsets.fromLTRB(24, 34, 24, 28),
                    child: const Column(
                      children: [
                        AppLogo(size: 86),
                        SizedBox(height: 24),
                        Text(
                          'Dompet Kampus',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'GLOBAL',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            letterSpacing: 3,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Bayar, transfer, dan kelola uang kuliah\ndalam satu aplikasi yang aman.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontSize: 15,
                            color: AppColors.slate600,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  AppButton(
                    label: 'Buat Akun Baru',
                    onPressed: () => context.push('/register'),
                  ),
                  const SizedBox(height: 11),
                  AppButton(
                    label: 'Masuk ke Akun',
                    variant: AppButtonVariant.outline,
                    onPressed: () => context.push('/login'),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
