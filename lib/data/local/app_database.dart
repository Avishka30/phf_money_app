import 'package:drift/drift.dart';
import 'tables.dart';

part 'app_database.g.dart';


@DriftDatabase(tables: [Accounts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(LazyDatabase(() async => throw UnimplementedError('Database disabled for Chrome')));

  @override
  int get schemaVersion => 1;
}