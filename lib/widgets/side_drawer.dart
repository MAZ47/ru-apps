import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../routes/app_routes.dart';
import 'ru_seal.dart';
import 'drawer/drawer_row.dart';

/// Slides in from the left over a dimmed Home Screen: user identity header,
/// then ALL app features grouped by access type, then Log Out.
class AppSideDrawer extends StatelessWidget {
  final String userName;
  final String userSubtitle;
  final void Function(DrawerItem item)? onNavigate;
  final VoidCallback? onLogout;

  const AppSideDrawer({
    super.key,
    this.userName = 'Anika Rahman',
    this.userSubtitle = '3rd Year, CSE',
    this.onNavigate,
    this.onLogout,
  });

  // ---- Easy Access (no login) : features 1, 4-11 ----
  static const _easyAccess = [
    DrawerItem('Home', Icons.home_outlined, tabIndex: 0),
    DrawerItem('RU Directory', Icons.apartment_outlined, tabIndex: 2),
    DrawerItem('RU Notice', Icons.notifications_outlined, tabIndex: 3),
    DrawerItem('RU News', Icons.article_outlined, tabIndex: 1),
    DrawerItem('RU Events', Icons.event_outlined, route: AppRoutes.events),
    DrawerItem('Calendar', Icons.calendar_month_outlined, route: AppRoutes.calendar),
    DrawerItem('Bus', Icons.directions_bus_outlined, route: AppRoutes.bus),
    DrawerItem('Varsity Map & Route', Icons.map_outlined, route: AppRoutes.campusMap),
    DrawerItem('RU Videos', Icons.play_circle_outline, route: AppRoutes.videos),
    DrawerItem('Notification Settings', Icons.settings_outlined,
        route: AppRoutes.notificationSettings),
  ];

  // ---- Login Required : features 2, 3, 12, 13 ----
  static const _loginRequired = [
    DrawerItem('Central Library', Icons.local_library_outlined,
        route: AppRoutes.library,
        requiresLogin: true,
        loginRoute: AppRoutes.libraryLogin),
    DrawerItem('RU Medical', Icons.medical_services_outlined,
        route: AppRoutes.medical,
        requiresLogin: true,
        loginRoute: AppRoutes.medicalLogin),
    DrawerItem('RU Student Service', Icons.school_outlined,
        route: AppRoutes.studentService,
        requiresLogin: true,
        loginRoute: AppRoutes.studentServiceLogin),
    DrawerItem('RU Web Mail', Icons.mail_outline,
        route: AppRoutes.webmail,
        requiresLogin: true,
        loginRoute: AppRoutes.webmailLogin),
  ];

  void _select(BuildContext context, DrawerItem item) {
    Navigator.of(context).pop();
    onNavigate?.call(item);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.8,
      backgroundColor: AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            _IdentityHeader(userName: userName, userSubtitle: userSubtitle),
            const Divider(height: 1),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const _SectionHeader('Easy Access'),
                  for (final item in _easyAccess)
                    DrawerRow(item: item, onTap: () => _select(context, item)),
                  const Divider(height: 16),
                  const _SectionHeader('Login Required'),
                  for (final item in _loginRequired)
                    DrawerRow(item: item, onTap: () => _select(context, item)),
                ],
              ),
            ),
            const Divider(height: 1),
            DrawerRow(
              item: const DrawerItem('Log Out', Icons.logout, isDestructive: true),
              onTap: () {
                Navigator.of(context).pop();
                onLogout?.call();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Text('App Version 1.0.0', style: AppTypography.label),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.xs),
      child: Text(text.toUpperCase(),
          style: AppTypography.label.copyWith(letterSpacing: 1.0, fontWeight: FontWeight.w600)),
    );
  }
}

class _IdentityHeader extends StatelessWidget {
  final String userName;
  final String userSubtitle;
  const _IdentityHeader({required this.userName, required this.userSubtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RuSeal(size: 48),
          const SizedBox(height: AppSpacing.sm),
          Text('University of Rajshahi', style: AppTypography.body.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: AppSpacing.sm),
          Text(userName, style: AppTypography.cardTitle.copyWith(fontSize: 16)),
          Text(userSubtitle, style: AppTypography.label),
        ],
      ),
    );
  }
}