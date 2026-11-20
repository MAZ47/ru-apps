import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/notice.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common/section_label.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/notices/notice_row.dart';

class NoticeScreen extends StatelessWidget {
  final bool embedded;
  const NoticeScreen({super.key, this.embedded = false});

  @override
  Widget build(BuildContext context) {
    final notices = List<Notice>.from(MockDataService.instance.notices)..sort((a, b) => b.date.compareTo(a.date));

    final body = notices.isEmpty
        ? const EmptyState(message: 'No notices yet — check back soon.', icon: Icons.notifications_off_outlined)
        : ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            itemCount: notices.length + 1,
            separatorBuilder: (_, __) => const Divider(height: 1, indent: AppSpacing.md, endIndent: AppSpacing.md),
            itemBuilder: (context, i) {
              if (i == 0) return const SectionLabel('Latest Notices');
              return NoticeRow(notice: notices[i - 1]);
            },
          );

    if (embedded) return body;
    return Scaffold(appBar: const AppHeader(title: 'Notice Board', showBackButton: true), body: body);
  }
}






