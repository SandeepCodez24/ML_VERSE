import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ml_verse/widgets/GlowButton.dart';

class DesktopHomePage extends StatefulWidget {
  final String? userName;
  final String? email;
  const DesktopHomePage({
    required this.userName,
    required this.email,
    super.key,
  });

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Color(0xFF10002b), // Bright purple center
                    Color(0xFF4A2C6D), // Medium purple
                    Color(0xFF1D1135), // Dark purple edges
                    Color(0xFF0F0721), // Almost black edges
                  ],
                  stops: [0.1, 0.2, 0.3, 1.5],
                ),
              ),
              child: Stack(
                children: [
                  // Star field
                  CustomPaint(
                    size: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height,
                    ),
                    painter: StarFieldPainter(),
                  ),
                  // Sphere effect
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          center: const Alignment(-0.5, -0.5),
                          radius: 0.8,
                          colors: const [
                            Color(0xFFFFFFFF), // Light purple
                            Color(0xFFB894FF), // Medium purple
                            Color(0xFF180042), // Dark purple
                            Color(0xFF180042),
                          ],
                          stops: [0.0, 0.2, 0.5, 1.0],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFB894FF),
                            blurRadius: 80,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Circle outline
                  Center(
                    child: Container(
                      width: 500,
                      height: 500,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Column(
                    children: [
                      // Navigation bar
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.35,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.all(10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.08,
                                  width:
                                      MediaQuery.of(context).size.width * 0.035,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Image.asset(
                                    'assets/ML_verse_LOGO.png',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: const [
                                    NavItem(title: 'Features'),
                                    NavItem(title: 'Developers'),
                                    NavItem(title: 'Pricing'),
                                    NavItem(title: 'Changelog'),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),

                              const SizedBox(width: 0.6),
                            ],
                          ),
                        ),
                      ),

                      // Main content
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'ML VERSE',
                                style: GoogleFonts.inter(
                                  fontSize: 96,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Empower your data journey : Train, Compare and Encode',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'variables seamlessly beyond imagination',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              GlowButton(
                                height:
                                    MediaQuery.of(context).size.height * 0.052,
                                width: MediaQuery.of(context).size.width * 0.08,
                                buttonText: 'Join waitlist',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // page2
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class WaitlistButton extends StatelessWidget {
  const WaitlistButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8A56E5),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: const Text('Join waitlist'),
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;

  const NavItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.width * 0.01,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class StarFieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.8)
          ..style = PaintingStyle.fill;

    final random = Random(42); // Fixed seed for consistent stars

    // Create about 40-50 stars
    for (int i = 0; i < 45; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 1.5; // Small dots

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
