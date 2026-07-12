import 'package:drift/drift.dart';
import '../../../../data/local/app_database.dart';
import '../../domain/entities/account.dart' as domain;
import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AppDatabase _db;

  AccountRepositoryImpl(this._db);

  @override
  Future<List<domain.Account>> getAccounts() async {
    final accountsData = await _db.select(_db.accounts).get();
    return accountsData
        .map(
          (data) => domain.Account(
            id: data.id,
            name: data.name,
            balance: data.balance,
            createdAt: data.createdAt,
          ),
        )
        .toList();
  }

  @override
  Future<int> addAccount(String name, double startingBalance) async {
    return await _db
        .into(_db.accounts)
        .insert(
          AccountsCompanion(name: Value(name), balance: Value(startingBalance)),
        );
  }

  @override
  Stream<double> getTotalBalance() {
    final query = _db.selectOnly(_db.accounts)
      ..addColumns([_db.accounts.balance.sum()]);

    return query
        .map((row) => row.read(_db.accounts.balance.sum()) ?? 0.0)
        .watchSingle();
  }
}
