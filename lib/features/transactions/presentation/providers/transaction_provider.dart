import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../accounts/presentation/providers/account_provider.dart';

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

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'amount': amount,
    'note': note,
    'date': date.toIso8601String(),
  };

  factory AppTransaction.fromJson(Map<String, dynamic> json) => AppTransaction(
    id: json['id'],
    type: json['type'],
    amount: json['amount'],
    note: json['note'],
    date: DateTime.parse(json['date']),
  );
}

class TransactionNotifier extends Notifier<List<AppTransaction>> {
  static const _key = 'saved_transactions';

  @override
  List<AppTransaction> build() {
    _loadTransactions();
    return [];
  }

  Future<void> _loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      state = decoded.map((item) => AppTransaction.fromJson(item)).toList();
    }
  }

  Future<void> _saveTransactions(List<AppTransaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(
      transactions.map((tx) => tx.toJson()).toList(),
    );
    await prefs.setString(_key, encoded);
  }

  void addTransaction(String type, double amount, String note) {
    final newTx = AppTransaction(
      id: DateTime.now().millisecondsSinceEpoch,
      type: type,
      amount: amount,
      note: note,
      date: DateTime.now(),
    );

    state = [...state, newTx];
    _saveTransactions(state);

    final accountRepo =
        ref.read(accountRepositoryProvider) as MockAccountRepository;
    accountRepo.updateBalance(type == 'Income' ? amount : -amount);

    ref.invalidate(accountsProvider);
  }
}

final transactionProvider =
    NotifierProvider<TransactionNotifier, List<AppTransaction>>(() {
      return TransactionNotifier();
    });
