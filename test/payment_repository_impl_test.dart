import 'package:dompet_kampus_global/core/error/exceptions.dart';
import 'package:dompet_kampus_global/core/error/failures.dart';
import 'package:dompet_kampus_global/data/datasources/remote/payment_remote_datasource.dart';
import 'package:dompet_kampus_global/data/repositories/payment_repository_impl.dart';
import 'package:dompet_kampus_global/domain/entities/payment_result_entity.dart';
import 'package:flutter_test/flutter_test.dart';

class _UnauthorizedPaymentRemote implements PaymentRemoteDatasource {
  @override
  Future<({double amount, double balance})> topup(double amount) {
    throw const UnauthorizedException('Authorization header diperlukan');
  }

  @override
  Future<TransferResultEntity> transfer({
    required double amount,
    required String description,
    required String otpCode,
    required String otpType,
  }) {
    throw const UnauthorizedException('Authorization header diperlukan');
  }
}

void main() {
  test('payment repository menghentikan flow saat token tidak ada', () async {
    final repo = PaymentRepositoryImpl(_UnauthorizedPaymentRemote());

    expect(
      () => repo.transfer(
        amount: 150000,
        description: 'Pembayaran order FindYourFit',
        otpCode: '123456',
        otpType: 'totp',
      ),
      throwsA(
        isA<ServerFailure>().having(
          (e) => e.message,
          'message',
          'Sesi login habis. Silakan masuk ulang.',
        ),
      ),
    );
  });
}
