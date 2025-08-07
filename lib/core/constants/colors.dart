import 'package:flutter/material.dart';

class AppColors {
  // Cultour Brand Colors - matching the logo
  static const Color primary = Color(0xFFD73527); // Cultour red from logo
  static const Color primaryLight = Color(0xFFFFEBEA); // Light red tint
  static const Color primaryDark = Color(0xFFB91C1C); // Darker red for accents
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1A1A1A); // Near black like logo text
  static const Color textSecondary = Color(0xFF6B7280); // Subtle gray
  static const Color textOnPrimary = Colors.white; // White text on red
  
  // Background Colors
  static const Color background = Colors.white;
  static const Color backgroundLight = Color(0xFFFAFAFA); // Very light gray
  static const Color surface = Colors.white;
  
  // Border and Divider
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFF3F4F6);
  
  // Status Colors
  static const Color success = Color(0xFF059669);
  static const Color warning = Color(0xFFD97706);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF2563EB);
  
  // Gradient colors matching Cultour brand
  static const List<Color> primaryGradient = [
    Color(0xFFD73527), // Main Cultour red
    Color(0xFFEF4444), // Slightly lighter red
  ];
  
  // Additional accent colors for variety
  static const Color accent = Color(0xFF374151); // Dark gray like logo's black elements
  static const Color accentLight = Color(0xFFF9FAFB);
}
