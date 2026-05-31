import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dashboard/view_model/market_bloc.dart';
import '../../dashboard/view_model/market_event.dart';
import '../widgets/confirm_sell_button.dart';
import '../widgets/quantity_selector.dart';
import '../widgets/sell_summary_card.dart';
import '../widgets/stock_info_card.dart';

class SellShareScreen extends StatefulWidget {
  final String companyName;
  final double currentPrice;
  final int ownedShares;

  const SellShareScreen({
    super.key,
    required this.companyName,
    required this.currentPrice,
    required this.ownedShares,
  });

  @override
  State<SellShareScreen> createState() => _SellShareScreenState();
}

class _SellShareScreenState extends State<SellShareScreen> {
  int quantity = 1;

  double get transactionFee =>
      (quantity * widget.currentPrice) * 0.001;

  double get estimatedProceeds =>
      (quantity * widget.currentPrice) -
          transactionFee;

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0C1321),

      appBar: AppBar(
        backgroundColor: const Color(0xFF0C1321),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Sell Shares",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(
            screenWidth * 0.04,
          ),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              /// COMPANY INFO

              StockInfoCard(
                companyName:
                widget.companyName,
                currentPrice:
                widget.currentPrice,
                ownedShares:
                widget.ownedShares,
              ),

              const SizedBox(height: 24),

              /// PERFORMANCE CHART

              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:
                  const Color(0xFF151B2A),
                  borderRadius:
                  BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [

                    Positioned.fill(
                      child: CustomPaint(
                        painter:
                        _ChartPainter(),
                      ),
                    ),

                    const Positioned(
                      top: 16,
                      left: 16,
                      child: Text(
                        "24H PERFORMANCE",
                        style: TextStyle(
                          color:
                          Colors.white60,
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// QUANTITY

              QuantitySelector(
                quantity: quantity,
                maxQuantity:
                widget.ownedShares,

                onIncrement: () {
                  if (quantity <
                      widget.ownedShares) {
                    setState(() {
                      quantity++;
                    });
                  }
                },

                onDecrement: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                  }
                },

                onMax: () {
                  setState(() {
                    quantity =
                        widget.ownedShares;
                  });
                },
              ),

              const SizedBox(height: 24),

              /// SUMMARY

              SellSummaryCard(
                marketPrice:
                widget.currentPrice,
                fee: transactionFee,
                estimatedAmount:
                estimatedProceeds,
              ),

              const SizedBox(height: 30),

              /// BUTTON

              ConfirmSellButton(
                onPressed: () {

                  if (widget.ownedShares <= 0) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "You don't own this stock",
                        ),
                      ),
                    );

                    return;
                  }

                  if (quantity > widget.ownedShares) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          "Not enough shares",
                        ),
                      ),
                    );

                    return;
                  }

                  context.read<MarketBloc>().add(
                    SellShareEvent(
                      companyName: widget.companyName,
                      quantity: quantity,
                    ),
                  );

                  ScaffoldMessenger.of(context)
                      .showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "$quantity shares sold successfully",
                      ),
                    ),
                  );

                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 12),

              const Center(
                child: Text(
                  "Funds will be credited to your wallet instantly",
                  textAlign:
                  TextAlign.center,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// CHART PAINTER

class _ChartPainter extends CustomPainter {
  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {
    final paint = Paint()
      ..color =
      const Color(0xFF4AE176)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(
      0,
      size.height * 0.75,
    );

    path.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.60,
      size.width * 0.25,
      size.height * 0.72,
    );

    path.quadraticBezierTo(
      size.width * 0.40,
      size.height * 0.90,
      size.width * 0.55,
      size.height * 0.45,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.25,
      size.width,
      size.height * 0.15,
    );

    canvas.drawPath(
      path,
      paint,
    );
  }

  @override
  bool shouldRepaint(
      CustomPainter oldDelegate) {
    return false;
  }
}