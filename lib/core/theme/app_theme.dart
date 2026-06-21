import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData light() => _build(
    brightness: Brightness.light,
    surface: AppColors.lightSurface,
    surfaceVariant: AppColors.lightSurfaceVariant,
    background: AppColors.lightBackground,
    text: AppColors.lightText,
    textSecondary: AppColors.lightTextSecondary,
    border: AppColors.lightBorder,
    primary: AppColors.primary,
    shadow: AppColors.ambientShadowLight,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    surface: AppColors.darkSurface,
    surfaceVariant: AppColors.darkSurfaceVariant,
    background: AppColors.darkBackground,
    text: AppColors.darkText,
    textSecondary: AppColors.darkTextSecondary,
    border: AppColors.darkBorder,
    primary: AppColors.primaryLight,
    shadow: AppColors.ambientShadowDark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color surface,
    required Color surfaceVariant,
    required Color background,
    required Color text,
    required Color textSecondary,
    required Color border,
    required Color primary,
    required Color shadow,
  }) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: brightness,
        surface: surface,
        onSurface: text,
        shadow: shadow,
      ).copyWith(
        primary: primary,
        secondary: AppColors.accent,
        tertiary: AppColors.teal,
        surface: surface,
        surfaceContainerHighest: surfaceVariant,
        onSurface: text,
        onSurfaceVariant: textSecondary,
        outline: border,
        shadow: shadow,
      ),
      scaffoldBackgroundColor: background,
      textTheme: _buildTextTheme(text),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        shadowColor: shadow.withValues(alpha: 0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: border),
        ),
      ),
      dividerColor: border,
      pageTransitionsTheme: _noTransitions(),
      splashFactory: NoSplash.splashFactory,
    );
  }

  static TextTheme _buildTextTheme(Color textColor) {
    final display = GoogleFonts.spaceGroteskTextTheme();
    final body = GoogleFonts.interTextTheme();

    return body.copyWith(
      displayLarge: display.displayLarge?.copyWith(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        letterSpacing: -2.2,
        color: textColor,
        height: 1.05,
      ),
      displayMedium: display.displayMedium?.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.5,
        color: textColor,
        height: 1.1,
      ),
      displaySmall: display.displaySmall?.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        letterSpacing: -1,
        color: textColor,
        height: 1.15,
      ),
      headlineLarge: display.headlineLarge?.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        color: textColor,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
        height: 1.7,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.6,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
    );
  }

  static PageTransitionsTheme _noTransitions() {
    return const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    );
  }
}
