import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/local/database_provider.dart';
import '../../data/repositories/account_repository_impl.dart';
import '../../domain/repositories/account_repository.dart';
import '../../domain/entities/account.dart';

// Provides the Account Repository instance
final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return AccountRepositoryImpl(db);
});

// Provides a Future that fetches the list of accounts from the database
final accountsProvider = FutureProvider<List<Account>>((ref) async {
  final repo = ref.watch(accountRepositoryProvider);
  return repo.getAccounts();
});