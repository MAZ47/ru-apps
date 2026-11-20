import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Data for one row in the side drawer's vertical menu.
///
/// Navigation target is one of:
///  - [tabIndex]: switch the Home bottom-nav tab (0 Home, 1 News, 2 Directory, 3 Notice)
///  - [route]: push a named route
/// If [requiresLogin] is true and the user is signed out, [loginRoute] is opened instead.
class DrawerItem {
  final String label;
  final IconData icon;
  final bool isDestructive;
  final int? tabIndex;
  final String? route;
  final bool requiresLogin;
  final String? loginRoute;

  const DrawerItem(
      this.label,
      this.icon, {
        this.isDestructive = false,
        this.tabIndex,
        this.route,
        this.requiresLogin = false,
        this.loginRoute,
      });
}

/// One 48pt-tall row: icon on the left, label on the right.
/// Login-required rows show a small lock at the end.
/// Destructive rows (e.g. "Log Out") render in Crimson.
class DrawerRow extends StatelessWidget {
  final DrawerItem item;
  final VoidCallback onTap;

  const DrawerRow({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textColor = item.isDestructive ? AppColors.crimsonRed : AppColors.slateGrey;
    final iconColor = item.isDestructive ? AppColors.crimsonRed : AppColors.royalBlue;

    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 48,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              Icon(item.icon, color: iconColor, size: 22),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  item.label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(color: textColor, fontSize: 14),
                ),
              ),
              if (item.requiresLogin)
                const Icon(Icons.lock_outline, size: 16, color: AppColors.slateGrey),
            ],
          ),
        ),
      ),
    );
  }
}