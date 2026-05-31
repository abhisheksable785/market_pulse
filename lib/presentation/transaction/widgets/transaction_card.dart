import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final bool isBuy;
  final String companyName;
  final int quantity;
  final double amount;
  final String time;

  const TransactionCard({
    super.key,
    required this.isBuy,
    required this.companyName,
    required this.quantity,
    required this.amount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF19202E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: isBuy
                  ? Colors.green.withOpacity(.15)
                  : Colors.red.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isBuy
                  ? Icons.shopping_cart
                  : Icons.sell,
              color: isBuy
                  ? Colors.green
                  : Colors.red,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isBuy
                      ? "Bought $quantity Shares"
                      : "Sold $quantity Shares",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  companyName,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isBuy ? '-' : '+'}₹${amount.toStringAsFixed(2)}",
                style: TextStyle(
                  color: isBuy
                      ? Colors.red
                      : Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                time,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}