import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../models/bus_route_model.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common/app_search_bar.dart';
import '../../widgets/common/section_label.dart';
import '../../widgets/empty_state.dart';

class BusScreen extends StatefulWidget {
  final bool embedded;
  const BusScreen({super.key, this.embedded = false});

  @override
  State<BusScreen> createState() => _BusScreenState();
}

class _BusScreenState extends State<BusScreen> {
  String _query = '';

  List<BusRoute> get _filtered {
    final q = _query.toLowerCase();
    return MockDataService.instance.busRoutes.where((r) {
      if (q.isEmpty) return true;
      return r.name.toLowerCase().contains(q) ||
          r.number.toLowerCase().contains(q) ||
          r.description.toLowerCase().contains(q) ||
          r.stops.any((s) => s.name.toLowerCase().contains(q));
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
            placeholder: 'Search route, stop, or destination',
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        Expanded(
          child: _filtered.isEmpty
              ? const EmptyState(message: 'No routes found.')
              : ListView(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            children: [
              const SectionLabel('Bus Routes'),
              ..._filtered.map((r) => _BusRouteCard(route: r)),
            ],
          ),
        ),
      ],
    );

    if (widget.embedded) return body;
    return Scaffold(
      appBar: const AppHeader(title: AppStrings.drawerTransport, showBackButton: true),
      body: body,
    );
  }
}

class _BusRouteCard extends StatelessWidget {
  final BusRoute route;
  const _BusRouteCard({required this.route});

  @override
  Widget build(BuildContext context) {
    final stops = [...route.stops]..sort((a, b) => a.order.compareTo(b.order));
    final from = stops.isNotEmpty ? stops.first.name : '';
    final to = stops.isNotEmpty ? stops.last.name : '';

    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.gridRadius),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.directions_bus, color: AppColors.royalBlue),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  route.name,
                  style: AppTypography.sectionHeader,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.gold,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Route ${route.number}',
                  style: AppTypography.label.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            '$from  →  $to',
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            route.description,
            style: AppTypography.label,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Stops: ${stops.map((s) => '${s.name} (${s.eta})').join(" · ")}',
            style: AppTypography.label,
          ),
        ],
      ),
    );
  }
}