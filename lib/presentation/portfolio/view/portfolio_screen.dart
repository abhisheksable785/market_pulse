import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dashboard/view_model/market_bloc.dart';
import '../../dashboard/view_model/market_state.dart';
import '../widgets/portfolio_card.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "My Portfolio",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: BlocBuilder<MarketBloc, MarketState>(
        builder: (context, state) {
          final totalPortfolioValue = state.portfolio.fold(0.0, (sum, item) {
            final company = state.companies.firstWhere(
              (e) => e.name == item.companyName,
            );

            return sum + (company.currentPrice * item.shares);
          });

          return SingleChildScrollView(
            padding: EdgeInsets.all(width * 0.04),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// TOTAL CARD
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF528DFF), Color(0xFF3568D4)],
                    ),

                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text("Total Portfolio Value"),

                      const SizedBox(height: 10),

                      Text(
                        "₹${totalPortfolioValue.toStringAsFixed(2)}",

                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white24,

                          borderRadius: BorderRadius.circular(30),
                        ),

                        child: Text("${state.portfolio.length} Holdings"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "Holdings",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                if (state.portfolio.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(40),

                    decoration: BoxDecoration(
                      color: const Color(0xFF19202E),

                      borderRadius: BorderRadius.circular(24),
                    ),

                    child: const Center(child: Text("No Shares Purchased Yet")),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: state.portfolio.length,

                    separatorBuilder: (_, __) => const SizedBox(height: 14),

                    itemBuilder: (context, index) {
                      final holding = state.portfolio[index];

                      final company = state.companies.firstWhere(
                        (e) => e.name == holding.companyName,
                      );

                      return PortfolioCard(
                        companyName: holding.companyName,

                        sharesOwned: holding.shares,

                        currentValue: company.currentPrice * holding.shares,

                        profitLoss:
                            (company.currentPrice * holding.shares) -
                            (holding.averageBuyPrice * holding.shares),
                      );
                    },
                  ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: const Color(0xFF19202E),

                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Portfolio Insight",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 12),

                      Text(
                        "Portfolio value updates automatically based on live market prices.",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _portfolioCard({
    required String companyName,
    required int shares,
    required String currentValue,
    required String profit,
    required String iconText,
    bool isProfit = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF19202E),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFF2E3544),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                iconText,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "$shares Shares",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currentValue,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                profit,
                style: TextStyle(
                  color: isProfit ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
