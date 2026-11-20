import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../models/map_location_model.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common/app_search_bar.dart';
import '../../widgets/common/section_label.dart';
import '../../widgets/empty_state.dart';

class CampusMapScreen extends StatefulWidget {
  final bool embedded;
  const CampusMapScreen({super.key, this.embedded = false});

  @override
  State<CampusMapScreen> createState() => _CampusMapScreenState();
}

class _CampusMapScreenState extends State<CampusMapScreen> {
  String _category = 'All';
  String _query = '';

  static const _categories = ['All', 'Academic', 'Admin', 'Hostel', 'Sports', 'Other'];

  List<MapLocation> get _filtered {
    return MockDataService.instance.mapLocations.where((m) {
      final matchesCat = _category == 'All' || m.category == _category;
      final matchesQuery = _query.isEmpty ||
          m.name.toLowerCase().contains(_query.toLowerCase()) ||
          m.description.toLowerCase().contains(_query.toLowerCase());
      return matchesCat && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
          child: AppSearchBar(
            placeholder: 'Search buildings, offices, amenities',
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, i) {
              final selected = _categories[i] == _category;
              return ChoiceChip(
                label: Text(_categories[i]),
                selected: selected,
                onSelected: (_) => setState(() => _category = _categories[i]),
                selectedColor: AppColors.royalBlue,
                labelStyle: AppTypography.label.copyWith(
                  color: selected ? AppColors.white : AppColors.slateGrey,
                ),
                backgroundColor: AppColors.white,
                side: BorderSide(
                  color: selected ? AppColors.royalBlue : AppColors.chipUnselectedBorder,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const SectionLabel('Locations'),
        Expanded(
          child: _filtered.isEmpty
              ? const EmptyState(message: 'No locations found.')
              : ListView.separated(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) => _LocationTile(location: _filtered[i]),
                ),
        ),
      ],
    );

    if (widget.embedded) return body;
    return Scaffold(
      appBar: const AppHeader(title: 'Campus Map', showBackButton: true),
      body: body,
    );
  }
}

class _LocationTile extends StatelessWidget {
  final MapLocation location;
  const _LocationTile({required this.location});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: AppColors.royalBlue,
        child: Icon(_iconForCategory(location.category), color: AppColors.white, size: 20),
      ),
      title: Text(
        location.name,
        style: AppTypography.body.copyWith(fontSize: 14, color: Colors.black87),
      ),
      subtitle: Text(
        '${location.category} · ${location.description}',
        style: AppTypography.label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.slateGrey),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(location.name),
            content: Text(
              '${location.category}\n\n${location.description}\n\n'
              'Coordinates: ${location.latitude.toStringAsFixed(4)}, '
              '${location.longitude.toStringAsFixed(4)}',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _iconForCategory(String c) {
    switch (c.toLowerCase()) {
      case 'academic':
        return Icons.school_outlined;
      case 'admin':
        return Icons.account_balance_outlined;
      case 'hostel':
        return Icons.holiday_village_outlined;
      case 'sports':
        return Icons.sports_soccer_outlined;
      default:
        return Icons.place_outlined;
    }
  }
}
