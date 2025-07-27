import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const List<BoxShadow> nueshadow = [
    BoxShadow(
      // More prominent light shadow
      // A very bright, almost white-green for a stronger highlight
      color: Color.fromARGB(255, 250, 255, 250),
      offset: Offset(-6, -6),
      // Slightly larger offset
      blurRadius: 15,
      // Increased blur for a softer, wider pop
      spreadRadius: 0,
    ),
    BoxShadow(
      // More prominent dark shadow
      // A darker, more distinct muted green for deeper contrast
      color: Color.fromARGB(255, 170, 180, 170),
      offset: Offset(6, 6),
      // Slightly larger offset
      blurRadius: 15,
      // Increased blur for a softer, wider pop
      spreadRadius: 0,
    ),
  ];
}
