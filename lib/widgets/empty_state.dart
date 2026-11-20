import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Minimalist empty-state used for zero search results / empty lists,
/// matching the app's clean line-icon family.
class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyState({
    super.key,
    this.message = 'No results found — try a different search term.',
    this.icon = Icons.search_off_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl * 2),
      child: Column(
        children: [
          Icon(icon, size: 56, color: AppColors.emptyStateGrey),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(message, textAlign: TextAlign.center, style: AppTypography.body),
          ),
        ],
      ),
    );
  }
}





