import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  final String companyName;
  final double price;
  final double change;
  final VoidCallback onBuy;
  final VoidCallback onSell;

  const StockCard({
    super.key,
    required this.companyName,
    required this.price,
    required this.change,
    required this.onBuy,
    required this.onSell,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPositive = change >= 0;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF19202E),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        children: [
          /// Company Icon
          Container(
            width: 52,
            height: 52,
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

          const SizedBox(width: 12),

          /// Company Info
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "₹${price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Icon(
                      isPositive
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: isPositive
                          ? Colors.green
                          : Colors.red,
                      size: 16,
                    ),

                    const SizedBox(width: 4),

                    Flexible(
                      child: Text(
                        "${isPositive ? '+' : ''}${change.toStringAsFixed(2)}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isPositive
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          /// Buttons
          SizedBox(
            width: screenWidth * 0.20,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: onBuy,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4AE176),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      "Buy",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                SizedBox(
                  width: double.infinity,
                  height: 36,
                  child: OutlinedButton(
                    onPressed: onSell,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.red,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      "Sell",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}