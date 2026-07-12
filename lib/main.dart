import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  // Ensures that the Flutter engine is fully initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Wrapping the entire app with ProviderScope to enable Riverpod state management
  runApp(const ProviderScope(child: MoneyApp()));
}
