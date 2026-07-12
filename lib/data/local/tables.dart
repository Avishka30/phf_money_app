import 'package:drift/drift.dart';

// Accounts Table
class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  RealColumn get balance => real().withDefault(const Constant(0.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Categories Table
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get icon => text()();
  TextColumn get color => text()();
  TextColumn get type => text()(); // 'income' or 'expense'
}

// Transactions Table
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get amount => real()();
  TextColumn get type => text()(); // 'income', 'expense', or 'transfer'
  TextColumn get note => text().nullable()();
  DateTimeColumn get date => dateTime()();
  IntColumn get accountId => integer().references(Accounts, #id)();
  IntColumn get categoryId => integer().references(Categories, #id)();
}

// Budgets Table
class Budgets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  RealColumn get amount => real()();
  IntColumn get month => integer()();
  IntColumn get year => integer()();
}
