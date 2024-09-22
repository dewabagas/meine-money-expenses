import 'package:go_router/go_router.dart';
import 'package:meine_money_expenses/presentation/core/pages/page_splash.dart';
import 'package:meine_money_expenses/presentation/routes/app_route_paths.dart';

class AppRouter {
  final GoRouter router = GoRouter(
      initialLocation: RoutePaths.splash,
      routerNeglect: true,
      routes: [
        GoRoute(
            path: RoutePaths.splash,
            builder: (context, state) => const PageSplash()),
      ]);
}
