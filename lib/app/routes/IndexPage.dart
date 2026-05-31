import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../presentation/dashboard/view/dashboard_screen.dart';
import '../../presentation/dashboard/widgets/custom_bottom_nav.dart';
import '../../presentation/portfolio/view/portfolio_screen.dart';
import '../../presentation/transaction/view/transaction_screen.dart';

class Indexpage extends StatefulWidget {
  const Indexpage({super.key});

  @override
  State<Indexpage> createState() =>
      _MainScreenState();
}

class _MainScreenState
    extends State<Indexpage> {

  int selectedIndex = 0;

  final List<Widget> pages = [
    const DashboardScreen(),
    const PortfolioScreen(),
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      body: SafeArea(
        child: pages[selectedIndex],
      ),

      bottomNavigationBar: Container(
        color: const Color(0xFF0B1220),
        child: CustomBottomNav(
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