import 'package:flutter/material.dart';

class ConfirmSellButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ConfirmSellButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.sell),
        label: const Text(
          "Confirm Sell",
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}