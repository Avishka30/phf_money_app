import 'package:flutter/material.dart';
import 'core/routing/app_router.dart';

class MoneyApp extends StatelessWidget {
  const MoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Using MaterialApp.router to support GoRouter navigation
    return MaterialApp.router(
      title: 'PHF Money App',
      // Hides the debug banner in the top right corner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Connects the router we created
      routerConfig: appRouter,
    );
  }
}
