/// Optional scraper layer for ru.ac.bd. The site doesn't expose a public
/// JSON API, so when we want a feature (e.g. latest notices, events)
/// before the official backend is ready, this is the fallback.
///
/// All methods return mock-shaped data right now. When we hook up a real
/// scraper, only these implementations change.
library;

import '../models/notice.dart';
import '../models/campus_event.dart';
import '../models/news_model.dart';
import '../models/department.dart';
import 'mock_data_service.dart';

class ScraperService {
  ScraperService(this._mock);
  final MockDataService _mock;

  /// Fetches the public notice board. Today this returns mock data;
  /// later we'll fetch HTML and parse it into [Notice] objects.
  Future<List<Notice>> fetchNotices() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mock.notices;
  }

  Future<List<CampusEvent>> fetchEvents() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mock.events;
  }

  Future<List<NewsModel>> fetchNews() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mock.news;
  }

  Future<List<Department>> fetchDirectory() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _mock.departments;
  }
}