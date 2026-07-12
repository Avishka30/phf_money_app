import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/transaction_provider.dart';

// ConsumerWidget to listen to the transaction provider
class TransactionsPage extends ConsumerWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the transaction list from the provider
    final transactions = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // If there are no transactions, show a placeholder message
      body: transactions.isEmpty
          ? const Center(
              child: Text(
                'No transactions yet. Add some! 💸',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          // Otherwise, build a list of transactions
          : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                // Reverse the index to show the newest transactions at the top
                final tx = transactions[transactions.length - 1 - index];
                final isIncome = tx.type == 'Income';

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: isIncome ? Colors.green.withAlpha(30) : Colors.red.withAlpha(30),
                      child: Icon(
                        isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                    ),
                    title: Text(
                      tx.note,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${tx.date.year}-${tx.date.month.toString().padLeft(2, '0')}-${tx.date.day.toString().padLeft(2, '0')}'),
                    trailing: Text(
                      '${isIncome ? '+' : '-'} Rs. ${tx.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isIncome ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}