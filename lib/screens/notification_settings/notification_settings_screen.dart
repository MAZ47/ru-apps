import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../services/notification_service.dart';
import '../../widgets/app_header.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _notifications = true;
  final bool _darkMode = false;

  @override
  void initState() {
    super.initState();
    _notifications = NotificationService.instance.enabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: AppStrings.notificationSettings, showBackButton: true),
      body: ListView(
        children: [
          SwitchListTile(
            activeThumbColor: AppColors.royalBlue,
            title: Text('Push Notifications',
                style: AppTypography.body.copyWith(fontSize: 14, color: Colors.black87)),
            subtitle: Text('Get alerts for notices and events', style: AppTypography.label),
            value: _notifications,
            onChanged: (v) => setState(() {
              _notifications = v;
              NotificationService.instance.setEnabled(v);
            }),
          ),
          SwitchListTile(
            activeThumbColor: AppColors.royalBlue,
            title: Text('Dark Mode',
                style: AppTypography.body.copyWith(fontSize: 14, color: Colors.black87)),
            subtitle: Text('Not yet available — coming soon', style: AppTypography.label),
            value: _darkMode,
            onChanged: null,
          ),
          const Divider(height: 1),
          ListTile(
            title: Text('App Version',
                style: AppTypography.body.copyWith(fontSize: 14, color: Colors.black87)),
            trailing: Text(AppStrings.appVersion, style: AppTypography.label),
          ),
        ],
      ),
    );
  }
}