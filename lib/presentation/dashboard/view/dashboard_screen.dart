import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../SellShareScreen/view/sell_share_screen.dart';
import '../../buy_share_screen/buy_share_screen.dart';
import '../../portfolio/widgets/portfolio_card.dart';

import '../view_model/market_bloc.dart';
import '../view_model/market_state.dart';

import '../widgets/wallet_card.dart';
import '../widgets/market_ticker.dart';
import '../widgets/stock_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        title: const Text(
          "MarketPulse",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.white),
          ),
        ],
      ),

      body: BlocBuilder<MarketBloc, MarketState>(
        builder: (context, state) {
          final portfolioValue = state.portfolio.fold(0.0, (sum, item) {
            final company = state.companies.firstWhere(
              (e) => e.name == item.companyName,
            );

            return sum + (company.currentPrice * item.shares);
          });

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WalletCard(
                  balance: state.walletBalance,

                  portfolioValue: portfolioValue,

                  profitPercent: 0,
                ),

                const SizedBox(height: 24),

                MarketTicker(
                  tickers: state.companies
                      .map(
                        (e) =>
                            TickerModel(symbol: e.name, change: e.priceChange),
                      )
                      .toList(),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Live Market",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                ListView.separated(
                  shrinkWrap: true,

                  physics: const NeverScrollableScrollPhysics(),

                  itemCount: state.companies.length,

                  separatorBuilder: (_, __) => const SizedBox(height: 12),

                  itemBuilder: (context, index) {
                    final company = state.companies[index];

                    return StockCard(
                      companyName: company.name,

                      price: company.currentPrice,

                      change: company.priceChange,

                      onBuy: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) => BuyShareScreen(
                              companyName: company.name,

                              symbol: company.name,

                              currentPrice: company.currentPrice,
                            ),
                          ),
                        );
                      },

                      onSell: () {
                        final holding = state.portfolio
                            .where((e) => e.companyName == company.name)
                            .toList();

                        final owned = holding.isEmpty
                            ? 0
                            : holding.first.shares;

                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) => SellShareScreen(
                              companyName: company.name,

                              currentPrice: company.currentPrice,

                              ownedShares: owned,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
