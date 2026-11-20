import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import 'ru_seal.dart';

/// The repeating header pattern: royal-blue fixed bar, hamburger OR back
/// arrow on the left, title (optionally with seal mark) centered, and an
/// optional trailing action (e.g. profile avatar) on the right.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showSeal;
  final Widget? trailing;
  final VoidCallback? onLeadingTap;

  const AppHeader({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.showSeal = false,
    this.trailing,
    this.onLeadingTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.royalBlue,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: SizedBox(
        width: AppSpacing.minTapTarget,
        height: AppSpacing.minTapTarget,
        child: IconButton(
          icon: Icon(showBackButton ? Icons.arrow_back : Icons.menu, color: AppColors.white),
          onPressed: onLeadingTap ??
              () {
                if (showBackButton) {
                  Navigator.of(context).maybePop();
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
        ),
      ),
      title: showSeal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RuSeal(size: 26),
                const SizedBox(width: AppSpacing.sm),
                Text(title, style: AppTypography.screenTitle),
              ],
            )
          : Text(title, style: AppTypography.screenTitle),
      actions: [
        if (trailing != null)
          Padding(padding: const EdgeInsets.only(right: AppSpacing.md), child: trailing!)
        else
          const SizedBox(width: AppSpacing.minTapTarget),
      ],
    );
  }
}

/// Home screen's header: same royal-blue bar, seal mark + title centered,
/// hamburger on the left (opens the side drawer), avatar on the right.
class HomeAppHeader extends AppHeader {
  const HomeAppHeader({super.key})
      : super(
          title: 'RU Apps',
          showSeal: true,
          trailing: const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.gold,
            child: Icon(Icons.person, color: AppColors.royalBlue, size: 18),
          ),
        );
}





