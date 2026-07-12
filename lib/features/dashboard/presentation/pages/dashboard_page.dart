import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import the account provider to access account data
import '../../../../features/accounts/presentation/providers/account_provider.dart';

// Change to ConsumerWidget to integrate Riverpod state management
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the accounts provider to get the latest data
    final accountsAsync = ref.watch(accountsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Balance',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              
              // Dynamically update the UI based on the provider's state
              accountsAsync.when(
                data: (accounts) {
                  // Calculate the total balance by summing up all account balances
                  final total = accounts.fold(0.0, (sum, acc) => sum + acc.balance);
                  return Text(
                    'Rs. ${total.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  );
                },
                // Show a loading spinner while data is being fetched
                loading: () => const CircularProgressIndicator(),
                // Display an error message if something goes wrong
                error: (err, stack) => Text('Error: $err', style: const TextStyle(color: Colors.red)),
              ),
              
              const SizedBox(height: 24),
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  // Using withAlpha(25) instead of withOpacity(0.1) to fix the deprecation warning
                  color: Colors.blue.withAlpha(25), 
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Income & Expense Chart\nWill Go Here 📈',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}