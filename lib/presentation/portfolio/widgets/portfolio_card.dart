import 'package:flutter/material.dart';

class PortfolioCard extends StatelessWidget {
  final String companyName;
  final int sharesOwned;
  final double currentValue;
  final double profitLoss;

  const PortfolioCard({
    super.key,
    required this.companyName,
    required this.sharesOwned,
    required this.currentValue,
    required this.profitLoss,
  });

  @override
  Widget build(BuildContext context) {
    final bool isProfit = profitLoss >= 0;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF19202E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(.08),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: const Color(0xFF2E3544),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                companyName[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "$sharesOwned Shares Owned",
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
                "₹${currentValue.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "${isProfit ? '+' : ''}₹${profitLoss.toStringAsFixed(2)}",
                style: TextStyle(
                  color:
                  isProfit ? Colors.green : Colors.red,
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