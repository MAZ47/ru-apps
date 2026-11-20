import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _items = [
    _NavItem('Home', Icons.home_outlined, Icons.home),
    _NavItem('News', Icons.article_outlined, Icons.article),
    _NavItem('Directory', Icons.apartment_outlined, Icons.apartment),
    _NavItem('Notices', Icons.notifications_outlined, Icons.notifications),
    _NavItem('More', Icons.more_horiz_outlined, Icons.more_horiz),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(top: BorderSide(color: AppColors.divider, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final selected = i == currentIndex;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(i),
                  child: SizedBox(
                    height: AppSpacing.minTapTarget + 12,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          selected ? item.filledIcon : item.icon,
                          color: selected ? AppColors.royalBlue : AppColors.slateGrey,
                          size: 24,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.label,
                          style: AppTypography.label.copyWith(
                            color: selected ? AppColors.royalBlue : AppColors.slateGrey,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData filledIcon;
  const _NavItem(this.label, this.icon, this.filledIcon);
}





