/// Single source of truth for RU Campus Hub brand colors.
///
/// Trim/borders (gold) never appear as text-on-white per WCAG contrast rules.
library;

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color royalBlue = Color(0xFF1E4B9C); // headers, primary, active
  static const Color crimsonRed = Color(0xFFD32F2F); // secondary / unread badges
  static const Color gold = Color(0xFFF2B705); // trim, borders, highlights only
  static const Color white = Color(0xFFFFFFFF); // backgrounds, cards
  static const Color slateGrey = Color(0xFF4A4A4A); // body text (WCAG AA)
  static const Color successGreen = Color(0xFF2E7D32); // status, kept distinct from crimson

  static const Color chipUnselectedBorder = slateGrey;
  static const Color divider = Color(0xFFE0E0E0);
  static const Color emptyStateGrey = Color(0xFF9E9E9E);
}




