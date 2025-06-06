import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
   CustomTextButton({
    super.key,
    required this.height,
    required this.widget,
    required this.text,
    required this.isSignUp,
  });

  final double height;
  final double widget;
  final String text;
  bool isSignUp;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.widget,
      child: TextButton(onPressed: (){}, child: Text(widget.text)));
  }
}
