import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class authTextFormCustom extends StatefulWidget {
  const authTextFormCustom({
    super.key,
    required this.boxText,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.isPassword = false,
    required this.controller,
    required this.width,
    required this.height,
  });
  final String boxText;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final double width;
  final double height;
  final bool isPassword;

  @override
  State<authTextFormCustom> createState() => _authTextFormCustomState();
}

class _authTextFormCustomState extends State<authTextFormCustom> {
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  bool _obsureText = true;
  bool _cricleboarder = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              widget.boxText,
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 18),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _cricleboarder = !_cricleboarder;
              });
            },
            child: Container(
              height: widget.height,
              width: widget.width,
              decoration: BoxDecoration(color: Colors.grey.shade800),
              child: Center(
                child: TextFormField(
                  key: _fieldKey,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                  controller: widget.controller,
                  obscureText: widget.isPassword ? _obsureText : false,
                  validator: widget.validator,
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.ltr,
                    hintText: widget.hintText,
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),

                    suffixIcon:
                        widget.isPassword
                            ? InkWell(
                              onTap: () {
                                setState(() {
                                  _obsureText = !_obsureText;
                                });
                              },
                              child: Icon(
                                // ignore: dead_code
                                _obsureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            )
                            : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
