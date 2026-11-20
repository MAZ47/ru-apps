import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// The "contact info updated quarterly" card at the bottom of the Directory.
class DisclaimerCard extends StatelessWidget {
  final String message;
  final String linkText;
  final VoidCallback? onLinkTap;

  const DisclaimerCard({
    super.key,
    this.message = 'Contact information is updated quarterly. For corrections, contact the ICT Cell.',
    this.linkText = 'Contact ICT Cell',
    this.onLinkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(AppSpacing.gridRadius),
        border: const Border(top: BorderSide(color: AppColors.royalBlue, width: 3)),
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: AppTypography.body),
          const SizedBox(height: AppSpacing.xs),
          InkWell(
            onTap: onLinkTap,
            child: Text(linkText, style: AppTypography.body.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}





