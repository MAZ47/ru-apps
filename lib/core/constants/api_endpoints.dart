/// Central list of API endpoints. Backend URLs for login-required services
/// (library, medical, student-service, webmail) will be supplied later by
/// ru.ac.bd — placeholders use a plausible path shape so swapping them is
/// a single-file change.
library;

class ApiEndpoints {
  ApiEndpoints._();

  /// Base domain for the live university site (used for scraping links).
  static const String baseSite = 'https://ru.ac.bd';

  /// Scraping/public-data entry points. The site has no public JSON API,
  /// so we'll fall back to a scraper layer that normalizes HTML into JSON.
  static const String news = '$baseSite/news';
  static const String noticeBoard = '$baseSite/notice';
  static const String events = '$baseSite/events';
  static const String directoryFaculties = '$baseSite/academic/faculties';
  static const String directoryAdmin = '$baseSite/administration';

  /// Public news/media feeds (used by the bus/video modules).
  static const String videoGallery = '$baseSite/media/videos';

  /// Backend base — to be replaced when the official RU API is published.
  /// Keeping one placeholder so the swap is mechanical.
  static const String backendBase = 'https://api.ruapps.example.com';

  // Auth-required services (TBD when ru.ac.bd publishes the API)
  static const String authLogin = '$backendBase/auth/login';
  static const String authRefresh = '$backendBase/auth/refresh';
  static const String authLogout = '$backendBase/auth/logout';

  static const String libraryCatalog = '$backendBase/library/catalog';
  static const String libraryBorrowed = '$backendBase/library/borrowed';

  static const String medicalRecords = '$backendBase/medical/records';

  static const String studentProfile = '$backendBase/student/profile';
  static const String studentCourses = '$backendBase/student/courses';
  static const String studentResults = '$backendBase/student/results';

  static const String webmailInbox = '$backendBase/webmail/inbox';
}




