import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/library_model.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common/section_label.dart';
import '../../widgets/empty_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<BorrowedBook> records = MockDataService.instance.borrowedBooks;
    return Scaffold(
      appBar: const AppHeader(title: 'Library', showBackButton: true),
      body: records.isEmpty
          ? const EmptyState(message: 'No records to show.')
          : ListView(
        children: [
          const SectionLabel('Borrowed & Due'),
          ...records.map((r) => _LibraryTile(book: r)),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

class _LibraryTile extends StatelessWidget {
  final BorrowedBook book;
  const _LibraryTile({required this.book});

  @override
  Widget build(BuildContext context) {
    final overdue = book.isOverdue;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: overdue ? AppColors.crimsonRed : AppColors.royalBlue,
        child: const Icon(Icons.menu_book, color: AppColors.white, size: 20),
      ),
      title: Text(
        book.title,
        style: AppTypography.body.copyWith(color: Colors.black87, fontSize: 14),
      ),
      subtitle: Text(
        '${book.author}\nDue ${book.dueDate.toString().split(' ').first}${overdue ? '  (overdue)' : ''}',
        style: AppTypography.label.copyWith(color: overdue ? AppColors.crimsonRed : null),
      ),
      isThreeLine: true,
      trailing: Text(
        book.fine > 0 ? 'Fine: ৳${book.fine.toStringAsFixed(0)}' : (overdue ? 'Overdue' : 'On loan'),
        style: AppTypography.label,
      ),
    );
  }
}