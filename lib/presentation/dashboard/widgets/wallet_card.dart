import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  final double balance;
  final double portfolioValue;
  final double profitPercent;

  const WalletCard({
    super.key,
    required this.balance,
    required this.portfolioValue,
    required this.profitPercent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF19202E),
            Color(0xFF0C1321),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFF4AE176),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "LIVE PORTFOLIO",
                style: TextStyle(
                  color: Color(0xFF4AE176),
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Total Portfolio Value",
            style: TextStyle(
              color: Colors.white60,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "₹${portfolioValue.toStringAsFixed(0)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              const Icon(
                Icons.trending_up,
                color: Color(0xFF4AE176),
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                "+$profitPercent%",
                style: const TextStyle(
                  color: Color(0xFF4AE176),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Container(
            height: 100,
            alignment: Alignment.bottomCenter,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _bar(40),
                _bar(60),
                _bar(50),
                _bar(80),
                _bar(70),
                _bar(95),
                _bar(85),
                _bar(100),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Divider(
            color: Colors.white10,
          ),

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Available Balance",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₹${balance.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Color(0xFFAFC6FF),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const Spacer(),


            ],
          ),
        ],
      ),
    );
  }

  Widget _bar(double height) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF4AE176).withOpacity(.4),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}