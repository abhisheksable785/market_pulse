import 'package:flutter/material.dart';

class StockInfoCard extends StatelessWidget {
  final String companyName;
  final double currentPrice;
  final int ownedShares;

  const StockInfoCard({
    super.key,
    required this.companyName,
    required this.currentPrice,
    required this.ownedShares,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [

        Row(
          children: [

            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF19202E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  companyName[0],
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  companyName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),


              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [

            Expanded(
              child: _infoCard(
                "CURRENT PRICE",
                "₹${currentPrice.toStringAsFixed(2)}",
                "+3.1%",
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _infoCard(
                "OWNED SHARES",
                "$ownedShares",
                "Available",
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoCard(
      String title,
      String value,
      String subtitle,
      ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF19202E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),

          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}