import 'package:go_router/go_router.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';

// GoRouter configuration for navigating between screens
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
  ],
);