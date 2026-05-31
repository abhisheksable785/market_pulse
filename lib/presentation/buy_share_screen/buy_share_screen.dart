import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SellShareScreen/widgets/quantity_selector.dart';
import '../SellShareScreen/widgets/stock_info_card.dart';
import '../dashboard/view_model/market_bloc.dart';
import '../dashboard/view_model/market_event.dart';


class BuyShareScreen extends StatefulWidget {
  final String companyName;
  final String symbol;
  final double currentPrice;

  const BuyShareScreen({
    super.key,
    required this.companyName,
    required this.symbol,
    required this.currentPrice,
  });

  @override
  State<BuyShareScreen> createState() => _BuyShareScreenState();
}

class _BuyShareScreenState extends State<BuyShareScreen> {
  int quantity = 1;

  double get estimatedTotal =>
      quantity * widget.currentPrice;

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
          "Buy Shares",
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

              /// STOCK INFO

              StockInfoCard(
                companyName:
                widget.companyName,
                currentPrice:
                widget.currentPrice,
                ownedShares: 0,
              ),

              const SizedBox(height: 24),

              /// CHART

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
                        "LIVE MARKET TREND",
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

              /// QUANTITY SELECTOR

              QuantitySelector(
                quantity: quantity,
                maxQuantity: 999,

                onIncrement: () {
                  setState(() {
                    quantity++;
                  });
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
                    quantity = 100;
                  });
                },
              ),

              const SizedBox(height: 24),

              /// SUMMARY CARD

              Container(
                padding:
                const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color:
                  const Color(0xFF19202E),
                  borderRadius:
                  BorderRadius.circular(
                      20),
                ),
                child: Column(
                  children: [

                    _row(
                      "Price Per Share",
                      "₹${widget.currentPrice.toStringAsFixed(2)}",
                    ),

                    const SizedBox(height: 12),

                    _row(
                      "Execution Fee",
                      "FREE",
                      valueColor:
                      Colors.green,
                    ),

                    const Divider(),

                    _row(
                      "Estimated Total",
                      "₹${estimatedTotal.toStringAsFixed(2)}",
                      isBold: true,
                      valueColor:
                      const Color(
                          0xFF528DFF),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// BUY BUTTON

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: () {

                    final marketState =
                        context.read<MarketBloc>().state;

                    final totalCost =
                        quantity * widget.currentPrice;

                    if (marketState.walletBalance <
                        totalCost) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            "Insufficient Balance",
                          ),
                        ),
                      );

                      return;
                    }

                    context.read<MarketBloc>().add(
                      BuyShareEvent(
                        companyName: widget.companyName,
                        quantity: quantity,
                      ),
                    );

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        backgroundColor:
                        const Color(0xFF528DFF),
                        content: Text(
                          "$quantity shares purchased successfully",
                        ),
                      ),
                    );

                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                  label:  Text(
                    "Buy for  ₹${estimatedTotal.toStringAsFixed(0)}",
                  ),
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    const Color(
                        0xFF528DFF),
                    foregroundColor:
                    Colors.white,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(
                          18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              const Center(
                child: Text(
                  "Settlement will be completed within T+2 days",
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

  Widget _row(
      String title,
      String value, {
        bool isBold = false,
        Color? valueColor,
      }) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color:
            valueColor ?? Colors.white,
            fontWeight: isBold
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(
      Canvas canvas,
      Size size) {
    final paint = Paint()
      ..color =
      const Color(0xFF528DFF)
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
      CustomPainter oldDelegate) =>
      false;
}