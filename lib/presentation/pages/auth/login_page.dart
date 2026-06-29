import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/theme/app_colors.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/glass_background.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/feature_icon.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/app_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const _webClientId =
      '744293814908-ur086paso7ukabh6miepeva1bsqojsop.apps.googleusercontent.com';

  String _email = '';
  String _pw = '';
  bool _showPw = false;
  bool _gLoading = false;

  bool get _valid => _email.contains('@') && _pw.length >= 4;

  Future<void> _loginWithGoogle() async {
    setState(() => _gLoading = true);
    try {
      debugPrint('[Auth] Google sign-in: memulai...');
      final googleSignIn = GoogleSignIn(serverClientId: _webClientId);
      await googleSignIn.signOut();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint('[Auth] Google sign-in: dibatalkan user');
        setState(() => _gLoading = false);
        return;
      }
      debugPrint('[Auth] Google sign-in: akun dipilih → ${googleUser.email}');

      final googleAuth = await googleUser.authentication;
      debugPrint(
          '[Auth] Google auth: accessToken=${googleAuth.accessToken != null ? "OK" : "NULL"}, '
          'idToken=${googleAuth.idToken != null ? "OK" : "NULL"}');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint('[Auth] Firebase sign-in OK → uid=${userCredential.user?.uid}');

      final idToken = await userCredential.user?.getIdToken();
      debugPrint(
          '[Auth] Firebase ID token: ${idToken != null ? "OK (${idToken.length} chars)" : "NULL"}');

      if (idToken != null && mounted) {
        debugPrint('[Auth] Kirim token ke backend → POST /v1/auth/verify-token');
        context.read<AuthBloc>().add(AuthLoginWithFirebase(idToken));
      }
    } catch (e, st) {
      debugPrint('[Auth] Google sign-in ERROR: $e\n$st');
      if (mounted) {
        final message = e is PlatformException &&
                e.code == 'sign_in_failed' &&
                (e.message ?? '').contains('ApiException: 10')
            ? 'Login Google belum terhubung. Periksa Firebase Android app, SHA-1, dan google-services.json.'
            : 'Login Google gagal: $e';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } finally {
      if (mounted) setState(() => _gLoading = false);
    }
  }

  Future<void> _loginWithEmail() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _pw,
      );
      final idToken = await userCredential.user?.getIdToken();
      if (idToken != null && mounted) {
        context.read<AuthBloc>().add(AuthLoginWithFirebase(idToken));
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Login gagal.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthNeedsVerification) {
          context.go('/2fa/totp', extra: {
            'mode': state.user.totpEnabled ? 'login' : 'setup',
          });
        } else if (state is AuthAuthenticated) {
          context.go('/home');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.message), backgroundColor: AppColors.red),
          );
        }
      },
      child: Scaffold(
        body: GlassBackground(
          dark: false,
          child: SafeArea(
            child: Column(
              children: [
                // Back button + subtle branding
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 20, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(DkgIcons.arrowLeft,
                            color: AppColors.ink, size: 22),
                        onPressed: () => context.go('/'),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.68),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.9)),
                          boxShadow: AppColors.shadowSoft,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppLogo(size: 18),
                            SizedBox(width: 5),
                            Text(
                              'Secure Wallet',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryDark,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GlassCard(
                        radius: 28,
                        color: AppColors.glassStrong.withValues(alpha: 0.82),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.9),
                          width: 1.1,
                        ),
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 26),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ── Header ──
                            const Text(
                              'Masuk',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                color: AppColors.ink,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Selamat datang kembali',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.slate500),
                            ),
                            const SizedBox(height: 28),

                            // ── Google Sign In ──
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final loading = state is AuthLoading || _gLoading;
                                return GestureDetector(
                                  onTap: loading ? null : _loginWithGoogle,
                                  child: Container(
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.9),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(alpha: 0.08),
                                          blurRadius: 24,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: loading
                                          ? const [
                                              SizedBox(
                                                width: 18,
                                                height: 18,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2.4,
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          AppColors.primary),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text('Menghubungkan…',
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'PlusJakartaSans',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.ink,
                                                  )),
                                            ]
                                          : [
                                              _GoogleIcon(),
                                              const SizedBox(width: 10),
                                              const Text(
                                                'Lanjut dengan Google',
                                                style: TextStyle(
                                                  fontFamily: 'PlusJakartaSans',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.ink,
                                                ),
                                              ),
                                            ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 24),

                            // ── Divider ──
                            Row(children: [
                              const Expanded(
                                  child: Divider(
                                      color: AppColors.line2, thickness: 0.5)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text('atau email',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.slate400,
                                    )),
                              ),
                              const Expanded(
                                  child: Divider(
                                      color: AppColors.line2, thickness: 0.5)),
                            ]),
                            const SizedBox(height: 24),

                            // ── Fields ──
                            AppField(
                              label: 'Email',
                              value: _email,
                              onChanged: (v) => setState(() => _email = v),
                              placeholder: 'nama@email.com',
                              prefixIcon:
                                  const Icon(DkgIcons.mail, size: 18),
                            ),
                            const SizedBox(height: 14),
                            AppField(
                              label: 'Kata sandi',
                              value: _pw,
                              onChanged: (v) => setState(() => _pw = v),
                              obscureText: !_showPw,
                              placeholder: '••••••••',
                              prefixIcon:
                                  const Icon(DkgIcons.lock, size: 18),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _showPw ? DkgIcons.eyeOff : DkgIcons.eye,
                                    size: 18,
                                    color: AppColors.slate400),
                                onPressed: () =>
                                    setState(() => _showPw = !_showPw),
                              ),
                            ),

                            // ── Forgot password ──
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('Lupa kata sandi?',
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      color: AppColors.primaryDark,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    )),
                              ),
                            ),
                            const SizedBox(height: 8),

                            // ── Login button ──
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) => GestureDetector(
                                onTap: _valid ? _loginWithEmail : null,
                                child: Container(
                                  height: 52,
                                  decoration: BoxDecoration(
                                    gradient: AppColors.liquidGradient,
                                    borderRadius: BorderRadius.circular(14),
                                    boxShadow: AppColors.shadowPrimary,
                                  ),
                                  child: Center(
                                    child: state is AuthLoading
                                        ? const SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.4,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                            ),
                                          )
                                        : const Text(
                                            'Masuk',
                                            style: TextStyle(
                                              fontFamily: 'PlusJakartaSans',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                              letterSpacing: 0.2,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            // ── Register link ──
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Belum punya akun? ',
                                    style: TextStyle(
                                        fontSize: 13.5,
                                        color:
                                            AppColors.slate400)),
                                GestureDetector(
                                  onTap: () => context.go('/register'),
                                  child: const Text('Daftar',
                                      style: TextStyle(
                                        fontFamily: 'PlusJakartaSans',
                                        color: AppColors.primaryDark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.5,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: Image.network(
        'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/24px-Google_%22G%22_logo.svg.png',
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.g_mobiledata_rounded, size: 22, color: Colors.red),
      ),
    );
  }
}
