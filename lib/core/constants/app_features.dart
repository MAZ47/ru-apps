import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';

/// One app feature (from the project's complete feature list).
class AppFeature {
  final String label;
  final IconData icon;
  final String route;
  final bool requiresLogin;
  final String? loginRoute;
  const AppFeature(this.label, this.icon, this.route,
      {this.requiresLogin = false, this.loginRoute});
}

class AppFeatures {
  AppFeatures._();

  /// Easy Access features (no login): 1, 4-11.
  static const easyAccess = [
    AppFeature('RU Directory', Icons.apartment_outlined, AppRoutes.directory),
    AppFeature('RU Notice', Icons.notifications_outlined, AppRoutes.notice),
    AppFeature('RU News', Icons.article_outlined, AppRoutes.news),
    AppFeature('RU Events', Icons.event_outlined, AppRoutes.events),
    AppFeature('Calendar', Icons.calendar_month_outlined, AppRoutes.calendar),
    AppFeature('Bus', Icons.directions_bus_outlined, AppRoutes.bus),
    AppFeature('Varsity Map & Route', Icons.map_outlined, AppRoutes.campusMap),
    AppFeature('RU Videos', Icons.play_circle_outline, AppRoutes.videos),
    AppFeature('Notification Setting', Icons.tune, AppRoutes.notificationSettings),
  ];

  /// Login Required features: 2, 3, 12, 13.
  static const loginRequired = [
    AppFeature('Central Library', Icons.local_library_outlined, AppRoutes.library,
        requiresLogin: true, loginRoute: AppRoutes.libraryLogin),
    AppFeature('RU Medical', Icons.medical_services_outlined, AppRoutes.medical,
        requiresLogin: true, loginRoute: AppRoutes.medicalLogin),
    AppFeature('RU Student Service', Icons.school_outlined, AppRoutes.studentService,
        requiresLogin: true, loginRoute: AppRoutes.studentServiceLogin),
    AppFeature('RU Web Mail', Icons.mail_outline, AppRoutes.webmail,
        requiresLogin: true, loginRoute: AppRoutes.webmailLogin),
  ];
}
