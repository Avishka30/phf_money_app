import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/account.dart' as domain;
import '../../domain/repositories/account_repository.dart';

class MockAccountRepository implements AccountRepository {
  final List<domain.Account> _accounts = [];
  final _balanceController = StreamController<double>.broadcast();
  static const _key = 'saved_accounts';

  MockAccountRepository() {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      _accounts.clear();
      for (var item in decoded) {
        _accounts.add(domain.Account(
          id: item['id'],
          name: item['name'],
          balance: item['balance'],
          createdAt: DateTime.parse(item['createdAt']),
        ));
      }
    } else {
      _accounts.add(domain.Account(
        id: 1,
        name: 'Default Wallet',
        balance: 0.0,
        createdAt: DateTime.now(),
      ));
      _saveAccounts();
    }
    _updateTotal();
  }

  Future<void> _saveAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> mappedList = _accounts.map((acc) => {
      'id': acc.id,
      'name': acc.name,
      'balance': acc.balance,
      'createdAt': acc.createdAt.toIso8601String(),
    }).toList();
    await prefs.setString(_key, jsonEncode(mappedList));
  }

  @override
  Future<List<domain.Account>> getAccounts() async => _accounts;

  @override
  Future<int> addAccount(String name, double startingBalance) async {
    final newAccount = domain.Account(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      balance: startingBalance,
      createdAt: DateTime.now(),
    );
    _accounts.add(newAccount);
    await _saveAccounts();
    _updateTotal();
    return newAccount.id;
  }

 
  Future<void> updateBalance(double amountChange) async {
    if (_accounts.isNotEmpty) {
      final acc = _accounts[0]; 
      _accounts[0] = domain.Account(
        id: acc.id,
        name: acc.name,
        balance: acc.balance + amountChange,
        createdAt: acc.createdAt,
      );
      await _saveAccounts();
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