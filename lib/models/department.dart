import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';

enum DirectoryGroup { faculty, administrative }

enum BadgeColor { royalBlue, crimson, gold, slate, success }

class Department {
  final String name;
  final String faculty; // faculty this department belongs to (for filtering)
  final String description;
  final DirectoryGroup group;
  final BadgeColor badgeColor;
  final IconData icon;

  const Department({
    required this.name,
    required this.faculty,
    required this.description,
    required this.group,
    required this.badgeColor,
    required this.icon,
  });

  Color get badgeBackground {
    switch (badgeColor) {
      case BadgeColor.royalBlue:
        return AppColors.royalBlue;
      case BadgeColor.crimson:
        return AppColors.crimsonRed;
      case BadgeColor.gold:
        return AppColors.gold;
      case BadgeColor.slate:
        return AppColors.slateGrey;
      case BadgeColor.success:
        return AppColors.successGreen;
    }
  }
}

/// RU's 12 faculties, used both as filter chips and as the grouping key
/// for departments in the Directory list.
class Faculty {
  final String name;
  const Faculty(this.name);

  static const List<String> all = [
    'All',
    'Arts',
    'Law',
    'Science',
    'Business Studies',
    'Social Science',
    'Agriculture',
    'Engineering',
    'Fine Arts',
    'Life Sciences',
    'Earth & Environmental Sciences',
    'Fisheries',
    'Veterinary & Animal Sciences',
  ];
}