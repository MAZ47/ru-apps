/// Provider for the Notice Board feed.
library;

import 'package:flutter/foundation.dart';

import '../models/notice.dart';
import '../services/scraper_service.dart';

class NoticeProvider extends ChangeNotifier {
  NoticeProvider(this._scraper);
  final ScraperService _scraper;

  List<Notice> _notices = [];
  bool _loading = false;
  String? _error;

  List<Notice> get notices => List.unmodifiable(_notices);
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      final list = await _scraper.fetchNotices();
      list.sort((a, b) => b.date.compareTo(a.date));
      _notices = list;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void markAllRead() {
    _notices = _notices
        .map((n) => Notice(
              title: n.title,
              date: n.date,
              isUnread: false,
              category: n.category,
            ))
        .toList();
    notifyListeners();
  }
}
