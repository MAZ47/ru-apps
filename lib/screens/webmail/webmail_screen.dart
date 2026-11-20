import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../widgets/app_header.dart';
import '../../widgets/empty_state.dart';

/// Stub: opens the university webmail in the system browser once the real
/// SSO URL is supplied. Until then shows a friendly placeholder.
class WebmailScreen extends StatelessWidget {
  const WebmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Webmail', showBackButton: true),
      body: const Center(
        child: EmptyState(
          message:
              'Webmail inbox opens in your browser once the SSO URL is wired in. '
              'Your account is signed in.',
          icon: Icons.email_outlined,
        ),
      ),
    );
  }
}