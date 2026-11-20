import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/theme/app_theme.dart';
import '../../models/campus_event.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/events/event_summary_card.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<CampusEvent> _eventsForDay(DateTime day) {
    return MockDataService.instance.events
        .where((e) => e.date.year == day.year && e.date.month == day.month && e.date.day == day.day)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedDay ?? _focusedDay;
    final dayEvents = _eventsForDay(selected);

    return Scaffold(
      appBar: const AppHeader(title: 'Events & Calendar', showBackButton: true),
      body: ListView(
        children: [
          _CalendarCard(
            focusedDay: _focusedDay,
            selectedDay: selected,
            eventLoader: _eventsForDay,
            onDaySelected: (day, focused) => setState(() {
              _selectedDay = day;
              _focusedDay = focused;
            }),
            onPageChanged: (focused) => setState(() => _focusedDay = focused),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text('Events on this day', style: AppTypography.sectionHeader),
          ),
          const SizedBox(height: AppSpacing.sm),
          if (dayEvents.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text('No events scheduled.', style: AppTypography.body),
            )
          else
            ...dayEvents.map((e) => EventSummaryCard(event: e)),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}

/// The month calendar card with a royal-blue header and gold event dots.
class _CalendarCard extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final List<CampusEvent> Function(DateTime) eventLoader;
  final void Function(DateTime, DateTime) onDaySelected;
  final void Function(DateTime) onPageChanged;

  const _CalendarCard({
    required this.focusedDay,
    required this.selectedDay,
    required this.eventLoader,
    required this.onDaySelected,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.gridRadius),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: TableCalendar<CampusEvent>(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        eventLoader: eventLoader,
        onDaySelected: onDaySelected,
        onPageChanged: onPageChanged,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          decoration: const BoxDecoration(
            color: AppColors.royalBlue,
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.gridRadius)),
          ),
          titleTextStyle: AppTypography.screenTitle.copyWith(fontSize: 16),
          leftChevronIcon: const Icon(Icons.chevron_left, color: AppColors.white),
          rightChevronIcon: const Icon(Icons.chevron_right, color: AppColors.white),
        ),
        calendarStyle: CalendarStyle(
          selectedDecoration: const BoxDecoration(color: AppColors.royalBlue, shape: BoxShape.circle),
          todayDecoration: BoxDecoration(color: AppColors.royalBlue.withOpacity(0.25), shape: BoxShape.circle),
          markerDecoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
          markersMaxCount: 1,
          markerSize: 6,
          markerMargin: const EdgeInsets.only(top: 2),
        ),
      ),
    );
  }
}






