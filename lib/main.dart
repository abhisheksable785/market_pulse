import 'package:digi_market/presentation/dashboard/view_model/market_bloc.dart';
import 'package:digi_market/presentation/transaction/view/transaction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/dashboard/view/dashboard_screen.dart';
import 'presentation/dashboard/widgets/custom_bottom_nav.dart';
import 'presentation/portfolio/view/portfolio_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [

        BlocProvider<MarketBloc>(
          create: (_) => MarketBloc(),
        ),

      ],
      child: const MarketPulseApp(),
    ),
  );
}

class MarketPulseApp extends StatefulWidget {
  const MarketPulseApp({super.key});

  @override
  State<MarketPulseApp> createState() =>
      _MarketPulseAppState();
}

class _MarketPulseAppState
    extends State<MarketPulseApp> {

  int selectedIndex = 0;

  final List<Widget> pages = [
    const DashboardScreen(),
    const PortfolioScreen(),
    const DashboardScreen(), // Market Screen
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'MarketPulse',

      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor:
        const Color(0xFF0B1220),
        useMaterial3: true,
      ),

      home: Scaffold(
        body: pages[selectedIndex],

        bottomNavigationBar:
        CustomBottomNav(
          currentIndex: selectedIndex,

          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}