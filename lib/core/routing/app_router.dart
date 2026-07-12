import 'package:go_router/go_router.dart';
import '../widgets/main_wrapper.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/transactions/presentation/pages/transactions_page.dart';
import '../../features/budgets/presentation/pages/budgets_page.dart';
import '../../features/accounts/presentation/pages/add_account_page.dart';
import '../../features/transactions/presentation/pages/add_transaction_page.dart'; // අලුත් Import එක

// GoRouter configuration with StatefulShellRoute for Bottom Navigation
final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainWrapper(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/transactions',
              builder: (context, state) => const TransactionsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/budgets',
              builder: (context, state) => const BudgetsPage(),
            ),
          ],
        ),
      ],
    ),
    // Route for Add Account Page 
    GoRoute(
      path: '/add-account',
      builder: (context, state) => const AddAccountPage(),
    ),
    // අලුතින්ම දාපු Route එක (Add Transaction Page)
    GoRoute(
      path: '/add-transaction',
      builder: (context, state) => const AddTransactionPage(),
    ),
  ],
);