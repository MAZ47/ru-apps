/// Provider for the Events + Calendar screens.
library;

import 'package:flutter/foundation.dart';

import '../models/campus_event.dart';
import '../models/calendar_event_model.dart';
import '../services/mock_data_service.dart';
import '../services/scraper_service.dart';

class EventsProvider extends ChangeNotifier {
  EventsProvider(this._scraper, this._mock);
  final ScraperService _scraper;
  final MockDataService _mock;

  List<CampusEvent> _events = [];
  List<CalendarEvent> _calendar = [];
  bool _loading = false;
  String? _error;

  List<CampusEvent> get events => List.unmodifiable(_events);
  List<CalendarEvent> get academicCalendar => List.unmodifiable(_calendar);
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final fetched = await _scraper.fetchEvents();
      fetched.sort((a, b) => a.date.compareTo(b.date));
      _events = fetched;
      _calendar = _mock.calendarEvents;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
