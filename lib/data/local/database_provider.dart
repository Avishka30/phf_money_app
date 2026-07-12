import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';

// Provides a single, global instance of AppDatabase to the entire application
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});