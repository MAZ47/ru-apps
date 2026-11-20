import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/student_service_model.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common/section_label.dart';
import '../../widgets/empty_state.dart';

class StudentServiceScreen extends StatelessWidget {
  const StudentServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<StudentResult> results = MockDataService.instance.studentResults;
    return Scaffold(
      appBar: const AppHeader(title: 'Student Services', showBackButton: true),
      body: results.isEmpty
          ? const EmptyState(message: 'Nothing to show yet.')
          : ListView(
        children: [
          for (final r in results) ...[
            SectionLabel(r.semester),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'CGPA ${r.cgpa.toStringAsFixed(2)}  ·  ${r.totalCredits} credits',
                style: AppTypography.label,
              ),
            ),
            ...r.courses.map((c) => ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.royalBlue,
                child: Icon(Icons.fact_check_outlined, color: AppColors.white, size: 20),
              ),
              title: Text(c.title, style: AppTypography.body.copyWith(fontSize: 14)),
              subtitle: Text(
                '${c.code}  ·  ${c.instructor}  ·  ${c.credits.toStringAsFixed(1)} cr',
                style: AppTypography.label,
              ),
              trailing: Text(c.grade, style: AppTypography.cardTitle),
            )),
          ],
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}