import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// A section header label, e.g. "Faculties", "Latest Notices".
class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.xs),
      child: Text(label, style: AppTypography.sectionHeader),
    );
  }
}





