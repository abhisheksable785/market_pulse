import 'package:flutter/material.dart';
import '../../presentation/splash/view/splash_screen.dart';
import '../../presentation/dashboard/view/dashboard_screen.dart';
import '../../presentation/transaction/view/transaction_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        );
      case AppRoutes.history:
        return MaterialPageRoute(
          builder: (_) => const HistoryScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route Not Found'),
            ),
          ),
        );
    }
  }
}