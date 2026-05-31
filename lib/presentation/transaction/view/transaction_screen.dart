import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dashboard/view_model/market_bloc.dart';
import '../../dashboard/view_model/market_state.dart';
import '../../transaction/widgets/transaction_card.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Transaction History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<MarketBloc, MarketState>(
        builder: (context, state) {

          if (state.transactions.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.receipt_long,
                    size: 80,
                    color: Colors.white24,
                  ),

                  SizedBox(height: 16),

                  Text(
                    "No Transactions Yet",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    "Buy or sell shares to see history",
                    style: TextStyle(
                      color: Colors.white38,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),

            itemCount: state.transactions.length,

            separatorBuilder: (_, __) =>
            const SizedBox(height: 12),

            itemBuilder: (context, index) {

              final transaction =
              state.transactions[index];

              final time =
                  "${transaction.transactionTime.hour.toString().padLeft(2, '0')}:"
                  "${transaction.transactionTime.minute.toString().padLeft(2, '0')}";

              return TransactionCard(
                isBuy: transaction.isBuy,
                companyName:
                transaction.companyName,
                quantity:
                transaction.quantity,
                amount:
                transaction.totalAmount,
                time: time,
              );
            },
          );
        },
      ),
    );
  }
}