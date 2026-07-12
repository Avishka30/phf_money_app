import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/account.dart' as domain;
import '../../domain/repositories/account_repository.dart';

class MockAccountRepository implements AccountRepository {
  final List<domain.Account> _accounts = [];
  final _balanceController = StreamController<double>.broadcast();

  MockAccountRepository() {
    _balanceController.add(0.0);
  }

  @override
  Future<List<domain.Account>> getAccounts() async => _accounts;

  @override
  Future<int> addAccount(String name, double startingBalance) async {
    final newAccount = domain.Account(
      id: _accounts.length + 1,
      name: name,
      balance: startingBalance,
      createdAt: DateTime.now(),
    );
    _accounts.add(newAccount);
    _updateTotal();
    return newAccount.id;
  }

  // --- අලුතින් එකතු කරපු කෑල්ල (Balance එක අප්ඩේට් කරන්න) ---
  void updateBalance(double amountChange) {
    if (_accounts.isNotEmpty) {
      final acc = _accounts[0];
      _accounts[0] = domain.Account(
        id: acc.id,
        name: acc.name,
        balance: acc.balance + amountChange,
        createdAt: acc.createdAt,
      );
    } else {
      // Account එකක් නැත්නම් අලුතින් එකක් හදනවා
      addAccount('Default Wallet', amountChange > 0 ? amountChange : 0);
    }
    _updateTotal();
  }

  void _updateTotal() {
    double total = _accounts.fold(0, (sum, item) => sum + item.balance);
    _balanceController.add(total);
  }

  @override
  Stream<double> getTotalBalance() => _balanceController.stream;
}

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return MockAccountRepository();
});

final accountsProvider = FutureProvider<List<domain.Account>>((ref) async {
  final repo = ref.watch(accountRepositoryProvider);
  return repo.getAccounts();
});