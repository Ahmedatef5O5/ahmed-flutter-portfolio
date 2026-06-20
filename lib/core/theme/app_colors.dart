import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand colors
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9B94FF);
  static const Color accent = Color(0xFF00D4AA);

  // Light theme
  static const Color lightBackground = Color(0xFFFAFAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF3F3F7);
  static const Color lightText = Color(0xFF0D0D1A);
  static const Color lightTextSecondary = Color(0xFF6B6B80);
  static const Color lightBorder = Color(0xFFE8E8F0);

  // Dark theme
  static const Color darkBackground = Color(0xFF0A0A14);
  static const Color darkSurface = Color(0xFF131320);
  static const Color darkSurfaceVariant = Color(0xFF1E1E2E);
  static const Color darkText = Color(0xFFF0F0FF);
  static const Color darkTextSecondary = Color(0xFF8888AA);
  static const Color darkBorder = Color(0xFF2A2A40);

  // Semantic
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
}
