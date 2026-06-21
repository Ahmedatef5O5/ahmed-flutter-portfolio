import 'package:flutter/material.dart';

abstract class AppColors {
  // ── Brand ──────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryLight = Color(0xFF9B94FF);
  static const Color primaryDeep = Color(0xFF4B3FE0);

  static const Color accent = Color(0xFFFF8A5B);
  static const Color accentSoft = Color(0xFFFFB088);

  static const Color teal = Color(0xFF22D3C7);

  // ── Light theme ────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFFAF9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceVariant = Color(0xFFF2F1F8);
  static const Color lightText = Color(0xFF15131F);
  static const Color lightTextSecondary = Color(0xFF6A6780);
  static const Color lightBorder = Color(0xFFE7E5F0);

  // ── Dark theme ─────────────────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0B0A14);
  static const Color darkSurface = Color(0xFF14121F);
  static const Color darkSurfaceVariant = Color(0xFF1D1A2C);
  static const Color darkText = Color(0xFFF3F1FB);
  static const Color darkTextSecondary = Color(0xFF8E8AA8);
  static const Color darkBorder = Color(0xFF2B2740);

  // ── Semantic ───────────────────────────────────────────────────────────
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);

  // ── Gradient presets ──────────────────────────────────────────────────
  static const List<Color> brandGradient = [primary, accent];
  static const List<Color> coolGradient = [primary, teal];

  static Color glowPrimary(bool isDark) =>
      primary.withValues(alpha: isDark ? 0.22 : 0.14);
  static Color glowAccent(bool isDark) =>
      accent.withValues(alpha: isDark ? 0.18 : 0.10);

  static const Color ambientShadowDark = Color(0xFF03020A);
  static const Color ambientShadowLight = Color(0xFF2A2750);
}
