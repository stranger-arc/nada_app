import 'package:flutter/material.dart';


class CircularLabel extends StatelessWidget {
  final String? text;
  final Color color;
  final Color? textColor; // Made optional
  final double radius;

  const CircularLabel({
    super.key,
    this.text,
    this.color = Colors.grey,
    this.textColor, // No longer required
    this.radius = 25.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: text != null && text!.isNotEmpty
            ? Text(
          text!,
          style: TextStyle(
            // Use provided textColor or default to black if not provided
            color: textColor ?? Colors.black,
            fontSize: radius * 0.6,
            fontWeight: FontWeight.bold,
          ),
        )
            : null,
      ),
    );
  }
}