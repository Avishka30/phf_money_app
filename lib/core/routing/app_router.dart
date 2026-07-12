import 'package:go_router/go_router.dart';
import '../widgets/main_wrapper.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/transactions/presentation/pages/transactions_page.dart';
import '../../features/budgets/presentation/pages/budgets_page.dart';

// GoRouter configuration with StatefulShellRoute for Bottom Navigation
final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // Returns the MainWrapper which contains the BottomNavigationBar
        return MainWrapper(navigationShell: navigationShell);
      },
      branches: [
        // Branch 1: Dashboard
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        // Branch 2: Transactions
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/transactions',
              builder: (context, state) => const TransactionsPage(),
            ),
          ],
        ),
        // Branch 3: Budgets
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
  ],
);