import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/deeplink_callback_service.dart';
import '../../../core/services/deeplink_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/brutal_widgets.dart';

/// Halaman konfirmasi pembayaran yang dibuka dari deeplink merchant
/// (`kashi://pay?...` atau `https://kashi.app/pay?...`).
///
/// `data` bisa berupa:
///  - [DeeplinkPaymentData] → tampilkan ringkasan & tombol bayar
///  - [String]              → pesan error dari hasil parsing link
///  - `null`                → halaman dibuka tanpa data deeplink (link rusak)
class PaymentDeeplinkPage extends StatelessWidget {
  final Object? data;
  const PaymentDeeplinkPage({super.key, this.data});

  void _cancel(BuildContext context, DeeplinkPaymentData payload) {
    // Kirim callback cancelled ke app merchant sebelum kembali ke home.
    final cb = payload.callbackUrl;
    if (cb != null && cb.isNotEmpty) {
      DeeplinkCallbackService.notifyCancelled(
        callbackUrl: cb,
        reference: payload.reference,
      );
    }
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final payload = data;

    if (payload is! DeeplinkPaymentData) {
      final message = payload is String
          ? payload
          : 'Link pembayaran tidak ditemukan atau tidak valid.';
      return _ErrorView(message: message);
    }

    return PopScope(
        // Cegah pop default; tangani sendiri agar callback terkirim.
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _cancel(context, payload);
        },
        child: Scaffold(
          backgroundColor: AppColors.bg,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    16, MediaQuery.of(context).padding.top + 6, 16, 14),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close_rounded,
                          color: AppColors.white),
                      onPressed: () => _cancel(context, payload),
                    ),
                    const Expanded(
                      child: Text('Konfirmasi Pembayaran',
                          style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            color: AppColors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 17,
                          )),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.cardDark,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.black, width: 2),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.storefront_outlined,
                              size: 14, color: AppColors.orange),
                          const SizedBox(width: 6),
                          Text(payload.merchantName,
                              style: const TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppColors.orange,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: BrutalCard(
                          bgColor: AppColors.cardDark,
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Column(
                            children: [
                              const Text('Total Pembayaran',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.gray400,
                                  )),
                              const SizedBox(height: 6),
                              Text(CurrencyFormatter.format(payload.amount),
                                  style: const TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.white,
                                    letterSpacing: -0.5,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      BrutalCard(
                        bgColor: AppColors.cardDark,
                        borderRadius: 20,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        child: Column(
                          children: [
                            _DetailRow(
                                label: 'Merchant',
                                value: payload.merchantName),
                            const Divider(height: 1, color: AppColors.gray600),
                            _DetailRow(
                                label: 'Keterangan',
                                value: payload.description),
                            if (payload.reference != null &&
                                payload.reference!.isNotEmpty) ...[
                              const Divider(
                                  height: 1, color: AppColors.gray600),
                              _DetailRow(
                                  label: 'Referensi',
                                  value: payload.reference!),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      // Payment method
                      const Padding(
                        padding: EdgeInsets.only(left: 4, bottom: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Metode pembayaran',
                              style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppColors.gray400,
                              )),
                        ),
                      ),
                      BrutalCard(
                        bgColor: AppColors.cardDark,
                        padding: const EdgeInsets.all(14),
                        borderRadius: 20,
                        child: Row(
                          children: [
                            const AppLogo(size: 40),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Kashi',
                                      style: TextStyle(
                                        fontFamily: 'PlusJakartaSans',
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w800,
                                        color: AppColors.white,
                                      )),
                                  Text('Saldo · pembayaran instan',
                                      style: TextStyle(
                                          fontSize: 12.5,
                                          color: AppColors.gray400)),
                                ],
                              ),
                            ),
                            const Icon(Icons.check_rounded,
                                size: 20, color: AppColors.green),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      BrutalCard(
                        bgColor: AppColors.cardDark,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 10),
                        borderRadius: 16,
                        child: Row(
                          children: const [
                            Icon(Icons.shield_rounded,
                                size: 18, color: AppColors.orange),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Pembayaran ini akan diverifikasi dengan PIN dan kode 2FA '
                                'sesuai pengaturan keamanan akun kamu.',
                                style: TextStyle(
                                  fontFamily: 'PlusJakartaSans',
                                  fontSize: 12.5,
                                  color: AppColors.orange,
                                  fontWeight: FontWeight.w600,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.cardDark,
                padding: EdgeInsets.fromLTRB(
                    16, 12, 16, MediaQuery.of(context).padding.bottom + 16),
                child: BrutalButton(
                  label: 'Bayar ${CurrencyFormatter.format(payload.amount)}',
                  onPressed: () => context.go('/pin', extra: {
                    'kind': 'deeplink',
                    'amount': payload.amount,
                    'description': payload.description,
                    'merchantName': payload.merchantName,
                    'merchantId': payload.merchantId,
                    'reference': payload.reference,
                    'callbackUrl': payload.callbackUrl,
                  }),
                ),
              ),
            ],
          ),
        )); // PopScope + Scaffold
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 13.5,
                    color: AppColors.gray500,
                    fontFamily: 'PlusJakartaSans')),
          ),
          Expanded(
            child: Text(value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    fontFamily: 'PlusJakartaSans')),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BrutalCard(
                bgColor: AppColors.cardDark,
                padding: const EdgeInsets.all(16),
                borderRadius: 18,
                child: const Center(
                  child: Icon(Icons.link_off_rounded,
                      size: 30, color: AppColors.red),
                ),
              ),
              const SizedBox(height: 18),
              const Text('Link Pembayaran Tidak Valid',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PlusJakartaSans',
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  )),
              const SizedBox(height: 8),
              Text(message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 13.5, color: AppColors.gray500, height: 1.5)),
              const SizedBox(height: 28),
              BrutalButton(
                label: 'Kembali ke Beranda',
                onPressed: () => context.go('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
