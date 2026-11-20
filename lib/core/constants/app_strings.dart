/// Static user-facing strings. Keeping them in one place makes future
/// localization (English ↔ বাংলা) a single-file effort.
library;

class AppStrings {
  AppStrings._();

  // App-wide
  static const String appName = 'RU Apps';
  static const String universityName = 'University of Rajshahi';
  static const String appVersion = '1.0.0';

  // Bottom navigation tabs
  static const String navHome = 'Home';
  static const String navNews = 'News';
  static const String navDirectory = 'Directory';
  static const String navNotices = 'Notices';
  static const String navMore = 'More';

  // Common
  static const String seeAll = 'See all';
  static const String viewAll = 'View all';
  static const String loading = 'Loading…';
  static const String retry = 'Retry';
  static const String search = 'Search';
  static const String cancel = 'Cancel';
  static const String submit = 'Submit';
  static const String save = 'Save';
  static const String logout = 'Log Out';
  static const String settings = 'Settings';
  static const String noResults = 'No results found — try a different search term.';

  // Home dashboard
  static const String campusAlerts = 'Campus Alerts';
  static const String recentNews = 'Recent News';
  static const String quickAccess = 'Quick Access';

  // News
  static const String newsTitle = 'News';

  // Directory
  static const String directoryTitle = 'Directory';
  static const String facultiesSection = 'Faculties';
  static const String adminSection = 'Administrative Offices';

  // Notices
  static const String noticeTitle = 'Notice Board';
  static const String latestNotices = 'Latest Notices';

  // Events
  static const String eventsTitle = 'Events & Calendar';

  // Bus
  static const String busTitle = 'University Bus';
  static const String busSearchPlaceholder = 'Search route or stop';

  // Calendar
  static const String calendarTitle = 'Academic Calendar';

  // Videos
  static const String videosTitle = 'Campus Videos';

  // Campus Map
  static const String campusMapTitle = 'Campus Map';

  // More menu
  static const String moreTitle = 'More';

  // Settings
  static const String notificationSettings = 'Notification Settings';
  static const String pushNotifications = 'Push Notifications';
  static const String pushNotificationsSub =
      'Get alerts for notices and events';
  static const String darkMode = 'Dark Mode';
  static const String darkModeSub = 'Not yet available — coming soon';

  // Auth (login-required services)
  static const String signIn = 'Sign In';
  static const String signOut = 'Sign Out';
  static const String usernameOrId = 'Username / Student ID';
  static const String password = 'Password';
  static const String forgotPassword = 'Forgot password?';
  static const String invalidCredentials = 'Invalid credentials. Please try again.';
  static const String welcomeBack = 'Welcome back';
  static const String guestLoginHint =
      'These services will require your RU portal credentials once the API is available.';

  // Library
  static const String libraryTitle = 'Central Library';
  static const String libraryWelcome = 'Search the RU library catalog.';

  // Medical
  static const String medicalTitle = 'Medical Center';
  static const String medicalWelcome = 'View your medical records.';

  // Student Service
  static const String studentServiceTitle = 'Student Service';
  static const String studentServiceWelcome =
      'Access your academic and registration info.';

  // Webmail
  static const String webmailTitle = 'RU Webmail';
  static const String webmailWelcome = 'Access your RU webmail.';

  // Drawer
  static const String drawerCalendar = 'Calendar';
  static const String drawerEvents = 'Events';
  static const String drawerHome = 'Home';
  static const String drawerTransport = 'Transport';
  static const String drawerNews = 'News';

  // Library (extended)
  static const String catalogSearch = 'Search catalog';
  static const String myBorrowed = 'My Borrowed Books';
  static const String dueDate = 'Due Date';
}