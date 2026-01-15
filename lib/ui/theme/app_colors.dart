import 'package:flutter/material.dart';

class AppColors {
  // ===== DARK COLORS =====
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0B1220),
      Color.fromARGB(255, 47, 18, 42),
      Color(0xFF1E293B),
    ],
  );

  static const Color darkBackground = Color.fromARGB(255, 8, 36, 68);
  static const Color darkCard = Color(0xFF1E293B);
  static const Color darkTextPrimary = Color.fromARGB(255, 255, 255, 255);
  static const Color darkTextSecondary = Color.fromARGB(179, 255, 255, 255);

  // ===== LIGHT COLORS =====
  static const LinearGradient lightGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 21, 44, 68),
      Color.fromARGB(255, 255, 0, 0),
      Color.fromARGB(255, 0, 255, 26),
    ],
  );

  static const Color lightBackground = Color.fromARGB(255, 54, 182, 182);
  static const Color lightCard = Color.fromARGB(255, 54, 182, 182);
  static const Color lightTextPrimary = Color.fromARGB(255, 0, 0, 0);
  static const Color lightTextSecondary = Color.fromARGB(255, 255, 255, 255);
}
