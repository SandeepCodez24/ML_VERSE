import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ml_verse/constants/ImageString.dart';
import 'package:ml_verse/constants/strings.dart';

class heroSection extends StatefulWidget {
  const heroSection({super.key});

  @override
  State<heroSection> createState() => _heroSectionState();
}

class _heroSectionState extends State<heroSection> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0,
          colors: [
            Color(0xFF10002b), // Bright purple center
            Color(0xFF4A2C6D), // Medium purple
            Color(0xFF1D1135), // Dark purple edges
            Color(0xFF0F0721),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenWidth * 0.4,
                  child: Text(
                    textAlign: TextAlign.left,
                    AppStrings.herosectionTitle,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: screenWidth * 0.02,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: Text(
                    textAlign: TextAlign.left,
                    AppStrings.herosectionSubtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: screenWidth * 0.012,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: screenWidth * 0.24,
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                      image: AssetImage(ImageString.heroContainerImage2),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: AssetImage(ImageString.heroContainerImage1),
                          fit: BoxFit.cover,
                        ),
                      ),
                      height: screenHeight * 0.5,
                      width: screenWidth * 0.48,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(children: [
                 
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
