import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/department.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common/app_search_bar.dart';
import '../../widgets/common/section_label.dart';
import '../../widgets/directory/department_row.dart';
import '../../widgets/directory/disclaimer_card.dart';
import '../../widgets/directory/faculty_chip_row.dart';
import '../../widgets/empty_state.dart';

class DirectoryScreen extends StatefulWidget {
  /// When embedded inside Home's tab body, skip our own Scaffold/app bar —
  /// Home already provides the header, drawer, and bottom nav.
  final bool embedded;
  const DirectoryScreen({super.key, this.embedded = false});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  String _selectedFaculty = 'All';
  String _query = '';

  List<Department> get _filtered {
    return MockDataService.instance.departments.where((d) {
      final matchesFaculty = _selectedFaculty == 'All' || d.faculty == _selectedFaculty || d.faculty == 'All';
      final matchesQuery = _query.isEmpty ||
          d.name.toLowerCase().contains(_query.toLowerCase()) ||
          d.description.toLowerCase().contains(_query.toLowerCase());
      return matchesFaculty && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final body = _buildBody();
    if (widget.embedded) return body;
    return Scaffold(appBar: const AppHeader(title: 'Directory', showBackButton: true), body: body);
  }

  Widget _buildBody() {
    final faculties = _filtered.where((d) => d.group == DirectoryGroup.faculty).toList();
    final admin = _filtered.where((d) => d.group == DirectoryGroup.administrative).toList();
    final isEmpty = faculties.isEmpty && admin.isEmpty;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
          child: AppSearchBar(
            placeholder: 'Search by name, department, or office',
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        FacultyChipRow(
          selected: _selectedFaculty,
          onSelected: (faculty) => setState(() => _selectedFaculty = faculty),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: isEmpty ? const EmptyState() : _DepartmentList(faculties: faculties, admin: admin),
        ),
      ],
    );
  }
}

/// Grouped "Faculties" / "Administrative Offices" list plus the ICT
/// disclaimer card at the bottom.
class _DepartmentList extends StatelessWidget {
  final List<Department> faculties;
  final List<Department> admin;
  const _DepartmentList({required this.faculties, required this.admin});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      children: [
        if (faculties.isNotEmpty) ...[
          const SectionLabel('Faculties'),
          ...faculties.map((d) => DepartmentRow(department: d)),
        ],
        if (admin.isNotEmpty) ...[
          const SectionLabel('Administrative Offices'),
          ...admin.map((d) => DepartmentRow(department: d)),
        ],
        const SizedBox(height: AppSpacing.md),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: DisclaimerCard(),
        ),
      ],
    );
  }
}






