import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/account.dart' as domain;
import '../../domain/repositories/account_repository.dart';


class MockAccountRepository implements AccountRepository {
  final List<domain.Account> _accounts = [];
  final _balanceController = StreamController<double>.broadcast();

  MockAccountRepository() {
    _balanceController.add(0.0); // Initial balance
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
    
    
    double total = _accounts.fold(0, (sum, item) => sum + item.balance);
    _balanceController.add(total);
    
    return newAccount.id;
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