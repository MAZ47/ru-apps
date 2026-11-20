import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../models/calendar_event_model.dart';
import '../../models/campus_event.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/common/section_label.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/events/event_summary_card.dart';

class CalendarScreen extends StatefulWidget {
  final bool embedded;
  const CalendarScreen({super.key, this.embedded = false});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<CalendarEvent> _eventsForDay(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    return MockDataService.instance.calendarEvents.where((e) {
      final start = DateTime(e.startDate.year, e.startDate.month, e.startDate.day);
      final end = e.endDate == null
          ? start
          : DateTime(e.endDate!.year, e.endDate!.month, e.endDate!.day);
      // Multi-day events (exams, etc.) show on every day in their range.
      return !d.isBefore(start) && !d.isAfter(end);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedDay ?? _focusedDay;
    final dayEvents = _eventsForDay(selected);

    final body = Column(
      children: [
        Container(
          margin: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSpacing.gridRadius),
            boxShadow: const [
              BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
          child: TableCalendar<CalendarEvent>(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(selected, day),
            eventLoader: _eventsForDay,
            onDaySelected: (day, focused) => setState(() {
              _selectedDay = day;
              _focusedDay = focused;
            }),
            onPageChanged: (focused) => setState(() => _focusedDay = focused),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              decoration: const BoxDecoration(
                color: AppColors.royalBlue,
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(AppSpacing.gridRadius)),
              ),
              titleTextStyle: AppTypography.screenTitle.copyWith(fontSize: 16),
              leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.white),
              rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.white),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration:
              const BoxDecoration(color: AppColors.royalBlue, shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  color: AppColors.royalBlue.withValues(alpha: 0.2), shape: BoxShape.circle),
              markerDecoration:
              const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
              markersMaxCount: 1,
              markerSize: 6,
            ),
          ),
        ),
        const SectionLabel('Academic calendar'),
        Expanded(
          child: dayEvents.isEmpty
              ? const EmptyState(message: 'Nothing scheduled for this day.')
              : ListView.builder(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            itemCount: dayEvents.length,
            itemBuilder: (context, i) => EventSummaryCard(
              event: _toCampusEvent(dayEvents[i]),
            ),
          ),
        ),
      ],
    );

    if (widget.embedded) return body;
    return Scaffold(
      appBar: const AppHeader(title: AppStrings.drawerCalendar, showBackButton: true),
      body: body,
    );
  }
}

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
];

String _fmt(DateTime d) => '${d.day} ${_months[d.month - 1]} ${d.year}';

/// Adapts an academic [CalendarEvent] to a [CampusEvent] so the shared
/// EventSummaryCard can display it.
CampusEvent _toCampusEvent(CalendarEvent e) {
  final summary = e.isMultiDay
      ? '${_fmt(e.startDate)} – ${_fmt(e.endDate!)}'
      : _fmt(e.startDate);
  return CampusEvent(
    title: e.title,
    date: e.startDate,
    summary: summary,
    type: e.category,
  );
}