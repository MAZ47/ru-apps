import 'package:flutter/material.dart';
import '../../models/department.dart';
import '../../core/theme/app_theme.dart';

/// One tappable row in the Directory list: colored badge, name,
/// one-line description, and a chevron.
class DepartmentRow extends StatelessWidget {
  final Department department;
  final VoidCallback? onTap;

  const DepartmentRow({super.key, required this.department, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: department.badgeBackground, shape: BoxShape.circle),
              child: Icon(department.icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(department.name, style: AppTypography.cardTitle),
                  Text(department.description, style: AppTypography.body, maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.slateGrey),
          ],
        ),
      ),
    );
  }
}





