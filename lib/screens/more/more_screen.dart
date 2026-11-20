import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_header.dart';
import '../../widgets/drawer/drawer_row.dart';
import '../events/events_screen.dart';

/// "More" tab: same item shape as the drawer's DrawerItem, shown as a
/// standard ListTile list instead of the drawer's compact row.
class MoreScreen extends StatelessWidget {
  final bool embedded;
  const MoreScreen({super.key, this.embedded = false});

  static const _items = [
    DrawerItem('Calendar', Icons.calendar_month_outlined),
    DrawerItem('Events', Icons.event_outlined),
    DrawerItem('Transport', Icons.directions_bus_outlined),
    DrawerItem('Settings', Icons.settings_outlined),
    DrawerItem('Log Out', Icons.logout, isDestructive: true),
  ];

  void _onTap(BuildContext context, DrawerItem item) {
    if (item.label == 'Events' || item.label == 'Calendar') {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const EventsScreen()));
    } else if (item.label == 'Settings') {
      Navigator.of(context).pushNamed(AppRoutes.notificationSettings);
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      itemCount: _items.length,
      separatorBuilder: (_, __) => const Divider(height: 1, indent: AppSpacing.md, endIndent: AppSpacing.md),
      itemBuilder: (context, i) {
        final item = _items[i];
        return ListTile(
          minVerticalPadding: AppSpacing.md,
          leading: Icon(item.icon, color: item.isDestructive ? AppColors.crimsonRed : AppColors.royalBlue),
          title: Text(
            item.label,
            style: AppTypography.body.copyWith(
              color: item.isDestructive ? AppColors.crimsonRed : Colors.black87,
              fontSize: 14,
            ),
          ),
          trailing: item.isDestructive ? null : const Icon(Icons.chevron_right, color: AppColors.slateGrey),
          onTap: () => _onTap(context, item),
        );
      },
    );

    if (embedded) return body;
    return Scaffold(appBar: const AppHeader(title: 'More', showBackButton: true), body: body);
  }
}





