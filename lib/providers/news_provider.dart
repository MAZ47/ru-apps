/// Provider for the news feed (carousel + list).
library;

import 'package:flutter/foundation.dart';

import '../models/news_model.dart';
import '../services/scraper_service.dart';

class NewsProvider extends ChangeNotifier {
  NewsProvider(this._scraper);
  final ScraperService _scraper;

  List<NewsModel> _items = [];
  bool _loading = false;
  String? _error;

  List<NewsModel> get items => List.unmodifiable(_items);
  bool get loading => _loading;
  String? get error => _error;

  Future<void> load() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _items = await _scraper.fetchNews();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
