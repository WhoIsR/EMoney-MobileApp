import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../blocs/account/account_bloc.dart';
import '../../widgets/transaction_row.dart';
import '../../widgets/brutal_widgets.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String _tab = 'all';

  @override
  void initState() {
    super.initState();
    context.read<AccountBloc>().add(AccountLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).padding.top + 12, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Riwayat',
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                      letterSpacing: -0.3,
                    )),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ['all', 'Semua'],
                    ['out', 'Pengeluaran'],
                    ['in', 'Pemasukan']
                  ]
                      .map((t) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => setState(() => _tab = t[0]),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _tab == t[0]
                                      ? AppColors.orange
                                      : AppColors.cardDark,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: AppColors.black,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black,
                                      blurRadius: 0,
                                      offset: _tab == t[0]
                                          ? const Offset(3, 3)
                                          : const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Text(t[1],
                                    style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: _tab == t[0]
                                          ? AppColors.black
                                          : AppColors.gray400,
                                    )),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 14),
                const Divider(height: 1, color: AppColors.gray600),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountLoading) {
                  return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.orange));
                }
                if (state is AccountError) {
                  return Center(
                      child: Text(state.message,
                          style: const TextStyle(color: AppColors.gray400)));
                }
                if (state is AccountLoaded) {
                  List<TransactionEntity> txns = state.transactions;
                  if (_tab == 'in') {
                    txns = txns.where((t) => t.isCredit).toList();
                  }
                  if (_tab == 'out') {
                    txns = txns.where((t) => !t.isCredit).toList();
                  }

                  if (txns.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada transaksi',
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              color: AppColors.gray400)),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 110),
                    itemCount: 1,
                    itemBuilder: (_, __) {
                      return BrutalCard(
                        bgColor: AppColors.cardDark,
                        padding: EdgeInsets.zero,
                        borderRadius: 20,
                        shadowOffset: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 16, top: 14, bottom: 4),
                              child: Text('Hari ini',
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.gray400,
                                  )),
                            ),
                            ...txns.map((txn) => TransactionRow(
                                  icon: txn.isCredit ? 'topup' : 'send',
                                  tone: txn.isCredit ? 'green' : 'blue',
                                  title: txn.description.isEmpty
                                      ? (txn.isCredit ? 'Top Up' : 'Transaksi')
                                      : txn.description,
                                  subtitle:
                                      '${txn.createdAt.day}/${txn.createdAt.month}/${txn.createdAt.year}',
                                  amount: CurrencyFormatter.format(txn.amount),
                                  isCredit: txn.isCredit,
                                )),
                            const SizedBox(height: 6),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
