/// Brand Foundations for RU Campus Hub.
/// Colors, type scale, spacing grid and tap-target sizing all live here so
/// every screen pulls from one single source of truth.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

// Re-export so every file that imports app_theme.dart still sees AppColors.
export '../constants/app_colors.dart';

class AppSpacing {
  AppSpacing._();

  /// 8-point spacing grid.
  static const double unit = 8.0;
  static const double xs = unit * 0.5; // 4
  static const double sm = unit; // 8
  static const double md = unit * 2; // 16
  static const double lg = unit * 3; // 24
  static const double xl = unit * 4; // 32

  /// Minimum tap target enforced app-wide.
  static const double minTapTarget = 44.0;
  static const double gridRadius = 12.0;
}

class AppTypography {
  AppTypography._();

  static TextStyle get screenTitle => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle get sectionHeader => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.royalBlue,
  );

  static TextStyle get cardTitle => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF212121),
  );

  static TextStyle get body => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.normal,
    color: AppColors.slateGrey,
  );

  static TextStyle get label => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.slateGrey,
  );
}

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.royalBlue,
      primary: AppColors.royalBlue,
      secondary: AppColors.crimsonRed,
      surface: AppColors.white,
    ),
    fontFamily: GoogleFonts.inter().fontFamily,
  );

  return base.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.royalBlue,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.screenTitle,
      iconTheme: const IconThemeData(color: AppColors.white),
    ),
    dividerColor: AppColors.divider,
    iconTheme: const IconThemeData(color: AppColors.royalBlue, size: 24),
    textTheme: base.textTheme.copyWith(
      titleLarge: AppTypography.screenTitle,
      titleMedium: AppTypography.sectionHeader,
      titleSmall: AppTypography.cardTitle,
      bodyMedium: AppTypography.body,
      labelSmall: AppTypography.label,
    ),
  );
}