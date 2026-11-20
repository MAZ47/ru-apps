import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// The gold-bordered "Campus Alerts" card on Home, with a "View all" link.
class CampusAlertsCard extends StatelessWidget {
  final String message;
  final VoidCallback onViewAll;

  const CampusAlertsCard({
    super.key,
    this.message = 'Admission test result has been published.',
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.gridRadius),
        border: const Border(left: BorderSide(color: AppColors.gold, width: 4)),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          const Icon(Icons.notifications_active_outlined, color: AppColors.crimsonRed),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Campus Alerts', style: AppTypography.cardTitle),
                Text(message, style: AppTypography.body),
              ],
            ),
          ),
          TextButton(
            onPressed: onViewAll,
            child: Text('View all', style: AppTypography.body.copyWith(color: AppColors.royalBlue)),
          ),
        ],
      ),
    );
  }
}





