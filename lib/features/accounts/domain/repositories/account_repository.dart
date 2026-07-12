import '../entities/account.dart';

abstract class AccountRepository {
  Future<List<Account>> getAccounts();
  Future<int> addAccount(String name, double startingBalance);
  Stream<double> getTotalBalance();
}