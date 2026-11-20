import 'package:flutter/material.dart';
import '../../models/notice.dart';
import '../../core/theme/app_theme.dart';

/// One row in the Notice Board: title, relative date, and a Crimson
/// "New" badge when unread. Read notices show lighter, non-bold text.
class NoticeRow extends StatelessWidget {
  final Notice notice;
  const NoticeRow({super.key, required this.notice});

  static String _formatDate(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${d.day}/${d.month}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notice.title,
                  style: AppTypography.cardTitle.copyWith(
                    color: notice.isUnread ? const Color(0xFF212121) : AppColors.slateGrey,
                    fontWeight: notice.isUnread ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 2),
                Text(_formatDate(notice.date), style: AppTypography.label),
              ],
            ),
          ),
          if (notice.isUnread) const _NewBadge(),
        ],
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: AppSpacing.sm, top: 2),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: AppColors.crimsonRed, borderRadius: BorderRadius.circular(10)),
      child: const Text('New', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
    );
  }
}





