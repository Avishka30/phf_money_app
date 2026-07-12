import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../accounts/presentation/providers/account_provider.dart';

// Transaction Entity
class AppTransaction {
  final int id;
  final String type; 
  final double amount;
  final String note;
  final DateTime date;

  AppTransaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.note,
    required this.date,
  });
}

// Modern Riverpod 2.0 Notifier syntax
class TransactionNotifier extends Notifier<List<AppTransaction>> {
  @override
  List<AppTransaction> build() {
    return []; // Initial state is an empty list
  }

  void addTransaction(String type, double amount, String note) {
    final newTx = AppTransaction(
      id: state.length + 1,
      type: type,
      amount: amount,
      note: note,
      date: DateTime.now(),
    );
    
    // 1. Add new transaction to the state list
    state = [...state, newTx];

    // 2. Update the dashboard balance
    final accountRepo = ref.read(accountRepositoryProvider) as MockAccountRepository;
    accountRepo.updateBalance(type == 'Income' ? amount : -amount);
    
    // 3. Trigger a UI refresh for the dashboard
    ref.invalidate(accountsProvider);
  }
}

// Provider using the modern NotifierProvider
final transactionProvider = NotifierProvider<TransactionNotifier, List<AppTransaction>>(() {
  return TransactionNotifier();
});