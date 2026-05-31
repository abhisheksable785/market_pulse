import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final int maxQuantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onMax;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.maxQuantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onMax,
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

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [

              const Text(
                "Quantity To Sell",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextButton(
                onPressed: onMax,
                child: Text("MAX ($maxQuantity)"),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [

              IconButton(
                onPressed: onDecrement,
                icon: const Icon(Icons.remove),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    quantity.toString(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              IconButton(
                onPressed: onIncrement,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}