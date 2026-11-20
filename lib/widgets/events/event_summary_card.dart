import 'package:flutter/material.dart';
import '../../models/campus_event.dart';
import '../../core/theme/app_theme.dart';

/// Card shown below the calendar for events on the selected day.
class EventSummaryCard extends StatelessWidget {
  final CampusEvent event;
  const EventSummaryCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.gridRadius),
        border: const Border(left: BorderSide(color: AppColors.gold, width: 4)),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: AppColors.royalBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(event.type, style: AppTypography.label.copyWith(color: AppColors.royalBlue)),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(event.title, style: AppTypography.cardTitle),
          const SizedBox(height: AppSpacing.xs),
          Text(event.summary, style: AppTypography.body),
        ],
      ),
    );
  }
}





