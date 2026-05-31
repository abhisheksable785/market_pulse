import 'dart:async';

import 'package:digi_market/app/routes/IndexPage.dart';
import 'package:flutter/material.dart';

import '../../../app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final List<String> statusMessages = [
    "Initializing Market...",
    "Loading Companies...",
    "Generating Prices...",
    "Preparing Portfolio...",
    "Ready To Trade",
  ];

  int currentStatus = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.95,
      end: 1.05,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    Timer.periodic(
      const Duration(milliseconds: 800),
          (timer) {
        if (currentStatus < statusMessages.length - 1) {
          setState(() {
            currentStatus++;
          });
        } else {
          timer.cancel();
        }
      },
    );

    Future.delayed(
      const Duration(seconds: 4),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                const Indexpage(),
              ),
            );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Stack(
        children: [
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(.15),
              ),
            ),
          ),

          Positioned(
            bottom: -150,
            right: -100,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(.10),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF151F32),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(.25),
                          blurRadius: 25,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.show_chart,
                      size: 60,
                      color: Color(0xFF4F8CFF),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  "MarketPulse",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Trade Smart. Learn Fast.",
                  style: TextStyle(
                    color: Colors.blue.shade300,
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      const LinearProgressIndicator(
                        minHeight: 4,
                        backgroundColor: Color(0xFF1E293B),
                        color: Color(0xFF4F8CFF),
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        "Simulating Live Market",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          letterSpacing: 2,
                        ),
                      ),

                      const SizedBox(height: 10),

                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          statusMessages[currentStatus],
                          key: ValueKey(currentStatus),
                          style: const TextStyle(
                            color: Color(0xFF4F8CFF),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}