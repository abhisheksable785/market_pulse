import 'package:digi_market/presentation/dashboard/view_model/market_bloc.dart';
import 'package:digi_market/presentation/splash/view/splash_screen.dart';
import 'package:digi_market/presentation/transaction/view/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app/routes/app_routes.dart';
import 'presentation/dashboard/view/dashboard_screen.dart';
import 'presentation/dashboard/widgets/custom_bottom_nav.dart';
import 'presentation/portfolio/view/portfolio_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider<MarketBloc>(create: (_) => MarketBloc())],
      child: const MarketPulseApp(),
    ),
  );
}

class MarketPulseApp extends StatefulWidget {
  const MarketPulseApp({super.key});

  @override
  State<MarketPulseApp> createState() => _MarketPulseAppState();
}

class _MarketPulseAppState extends State<MarketPulseApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1220),
        useMaterial3: true,
      ),

      routes: {
        AppRoutes.splash: (_) =>
        const SplashScreen(),

        AppRoutes.dashboard: (_) =>
        const DashboardScreen(),
      },

      initialRoute: AppRoutes.splash,
    );
  }
}
