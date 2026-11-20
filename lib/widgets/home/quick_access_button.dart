import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// One circle in Home's feature grid. [locked] adds a small lock badge for
/// login-required features.
class QuickAccessButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool locked;
  final VoidCallback? onTap;

  const QuickAccessButton({
    super.key,
    required this.label,
    required this.icon,
    this.locked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.gold, width: 2),
                ),
                child: Icon(icon, color: AppColors.royalBlue),
              ),
              if (locked)
                Positioned(
                  right: -2,
                  bottom: -2,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColors.royalBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lock, size: 11, color: AppColors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}