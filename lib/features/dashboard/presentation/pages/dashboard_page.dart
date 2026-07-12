import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../transactions/presentation/providers/transaction_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the live transactions list
    final transactions = ref.watch(transactionProvider);

    // 2. Calculate totals on the fly (This guarantees real-time updates)
    final totalIncome = transactions
        .where((tx) => tx.type == 'Income')
        .fold(0.0, (sum, tx) => sum + tx.amount);

    final totalExpense = transactions
        .where((tx) => tx.type == 'Expense')
        .fold(0.0, (sum, tx) => sum + tx.amount);

    final totalBalance = totalIncome - totalExpense;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PHF Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Main Balance Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text('Total Balance', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      'Rs. ${totalBalance.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Income & Expense Row
            Row(
              children: [
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward, color: Colors.green, size: 16),
                              SizedBox(width: 4),
                              Text('Income', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Rs. ${totalIncome.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_upward, color: Colors.red, size: 16),
                              SizedBox(width: 4),
                              Text('Expense', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Rs. ${totalExpense.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            
            // Recent Transactions List
            Expanded(
              child: transactions.isEmpty 
                  ? const Center(child: Text('No transactions yet.', style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                      itemCount: transactions.length > 5 ? 5 : transactions.length, // Show max 5 latest
                      itemBuilder: (context, index) {
                        final tx = transactions[transactions.length - 1 - index]; // Newest first
                        final isIncome = tx.type == 'Income';
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: isIncome ? Colors.green.withAlpha(30) : Colors.red.withAlpha(30),
                            child: Icon(
                              isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                              color: isIncome ? Colors.green : Colors.red,
                            ),
                          ),
                          title: Text(tx.note),
                          subtitle: Text('${tx.date.year}-${tx.date.month.toString().padLeft(2, '0')}-${tx.date.day.toString().padLeft(2, '0')}'),
                          trailing: Text(
                            '${isIncome ? '+' : '-'} Rs.${tx.amount.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: isIncome ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}