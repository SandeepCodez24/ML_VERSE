import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ml_verse/auth/loginscreen.dart';
import 'package:ml_verse/constants/colors.dart';
import 'package:ml_verse/constants/strings.dart';

import 'signupScreen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final bool _isSignIn = true;
  final int _currentIndex = 0;

  final PageController _pageController = PageController();
  bool isSignedUp = true;
  int currentPage = 0;

  void switchPage() {
    int newPage = currentPage == 0 ? 1 : 0;
    _pageController.animateToPage(
      newPage,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: screenHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                color: Color(0xff060912),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(30),
                    height: screenHeight * 0.8,
                    width: screenWidth * 0.34,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFB8AEEB), // Light lavender at top left
                          Color(0xFF8F6ED5), // Mid purple
                          Color(0xFF512DA8), // Deeper purple
                          Color(0xFF1A1035), // Very dark purple
                          Color(0xFF080416), // Nearly black at bottom
                        ],
                        stops: [0.0, 0.1, 0.3, 0.6, 1.0],
                        transform: GradientRotation(
                          0.0,
                        ), // Slight rotation for the effect seen in image
                        tileMode: TileMode.clamp,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 8,
                          left: 8,
                          child: SizedBox(
                            height: 60,
                            width: 60,
                            child: Image.asset('assets/ML_verse_LOGO.png'),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 75,
                          child: Text(
                            'ML Verse',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                textAlign: TextAlign.left,
                                'Your App',
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.025,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.left,
                                'Your Data',
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.026,
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.left,
                                'Your Choice',
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.027,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                textAlign: TextAlign.left,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                '${AppStrings.appDescription}\n${AppStrings.appDescription2}',
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w400,
                                  fontSize: screenWidth * 0.011,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: screenHeight * 0.9,
                      width: screenWidth * 0.6,
                      child: Stack(
                        children: [
                          PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                currentPage = index;
                              });
                            },
                            children: [SignupScreen(), SigninScreen()],
                          ),
                          Positioned(
                            top: screenWidth * 0.01,
                            right: screenWidth * 0.01,
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              child: TextButton(
                                onPressed: () => switchPage(),
                                child: Text(
                                  currentPage == 0
                                      ? "Already have an account?  Login"
                                      : "Don't have an account?  SignUp",
                                  style: GoogleFonts.openSans(
                                    color: Color(0xff8766C5),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// sigin and sign up containers
                  /// as an page view type
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
