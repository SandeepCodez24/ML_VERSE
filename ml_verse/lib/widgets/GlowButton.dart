import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlowButton extends StatefulWidget {
  const GlowButton({
    super.key,
    required this.height,
    required this.width,
    required this.buttonText,
    required this.onPressed,
  });
  final double height;
  final double width;
  final String buttonText;
  final Function onPressed;
  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHover = false;
        });
      },
      child: InkWell(
        onTap: () => widget.onPressed(),
        child: Container(
          margin: const EdgeInsets.all(5),
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isHover ? 410 : 10),
            boxShadow:
                isHover
                    ? [
                      BoxShadow(
                        color: Color(0xff8766C5),
                        blurRadius: 20,
                        spreadRadius: 0.5,
                      ),
                      BoxShadow(
                        color: Color(0xff8766C5),
                        blurRadius: 20,
                        spreadRadius: 0.5,
                      ),
                    ]
                    : null,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff251245), Color(0xff4F2393)],
            ),
          ),
          child: Center(
            child: Text(
              widget.buttonText,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
