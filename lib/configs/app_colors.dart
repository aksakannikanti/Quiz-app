import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF564FD0);
  static const Color primaryLight = Color(0xFF8B85FF);
  
  // Background Colors
  static const Color darkSlateGray = Color(0xFF1E1E2D);
  static const Color darkSlateBlue = Color(0xFF2D2D44);
  
  // Accent Colors
  static const Color dodgerBlue = Color(0xFF4FC3F7);
  static const Color green = Color(0xFF4CAF50);
  static const Color red = Color(0xFFF44336);
  static const Color amber = Color(0xFFFFC107);
  
  // Text Colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFA0A0B0);
  
  // Gradient
  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, dodgerBlue],
  );
}