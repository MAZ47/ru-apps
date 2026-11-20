import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/medical_record_model.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common/section_label.dart';
import '../../widgets/empty_state.dart';

class MedicalScreen extends StatelessWidget {
  const MedicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MedicalRecord> records = MockDataService.instance.medicalRecords;
    return Scaffold(
      appBar: const AppHeader(title: 'Medical Records', showBackButton: true),
      body: records.isEmpty
          ? const EmptyState(message: 'No medical records on file.')
          : ListView(
        children: [
          const SectionLabel('Visit history'),
          ...records.map((r) => ListTile(
            leading: const CircleAvatar(
              backgroundColor: AppColors.successGreen,
              child: Icon(Icons.medical_services, color: AppColors.white, size: 20),
            ),
            title: Text(r.diagnosis, style: AppTypography.body.copyWith(fontSize: 14)),
            subtitle: Text(
              '${r.visitDate.toString().split(' ').first}  ·  ${r.doctor}\nRx: ${r.prescription}',
              style: AppTypography.label,
            ),
            isThreeLine: true,
          )),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}