import 'package:go_router/go_router.dart';
import '../widgets/main_wrapper.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/transactions/presentation/pages/transactions_page.dart';
import '../../features/budgets/presentation/pages/budgets_page.dart';
import '../../features/accounts/presentation/pages/add_account_page.dart';

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
    // New Route for Add Account Page (Placed outside the shell to cover the bottom nav bar)
    GoRoute(
      path: '/add-account',
      builder: (context, state) => const AddAccountPage(),
    ),
  ],
);