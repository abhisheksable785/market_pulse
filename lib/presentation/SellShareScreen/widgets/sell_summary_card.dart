import 'package:flutter/material.dart';

class SellSummaryCard extends StatelessWidget {
  final double marketPrice;
  final double fee;
  final double estimatedAmount;

  const SellSummaryCard({
    super.key,
    required this.marketPrice,
    required this.fee,
    required this.estimatedAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF19202E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [

          _row(
            "Market Price",
            "₹${marketPrice.toStringAsFixed(2)}",
          ),

          const SizedBox(height: 12),

          _row(
            "Transaction Fee",
            "₹${fee.toStringAsFixed(2)}",
          ),

          const Divider(),

          _row(
            "Estimated Proceeds",
            "₹${estimatedAmount.toStringAsFixed(2)}",
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _row(
      String title,
      String value, {
        bool isBold = false,
      }) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(title),

        Text(
          value,
          style: TextStyle(
            fontWeight: isBold
                ? FontWeight.bold
                : FontWeight.normal,
            color: isBold
                ? Colors.green
                : Colors.white,
          ),
        ),
      ],
    );
  }
}