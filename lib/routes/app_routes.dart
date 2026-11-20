/// Central route table. Keep route names + page builders in one place so
/// navigation from the home/drawer/quick-access buttons stays consistent.
library;

import 'package:flutter/material.dart';

import '../screens/directory/directory_screen.dart';
import '../screens/notice/notice_screen.dart';
import '../screens/events/events_screen.dart';
import '../screens/news/news_screen.dart';
import '../screens/bus/bus_screen.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/notification_settings/notification_settings_screen.dart';
import '../screens/videos/videos_screen.dart';
import '../screens/campus_map/campus_map_screen.dart';
import '../screens/more/more_screen.dart';
import '../screens/library/library_login_screen.dart';
import '../screens/library/library_screen.dart';
import '../screens/medical/medical_login_screen.dart';
import '../screens/medical/medical_screen.dart';
import '../screens/student_service/student_service_login_screen.dart';
import '../screens/student_service/student_service_screen.dart';
import '../screens/webmail/webmail_login_screen.dart';
import '../screens/webmail/webmail_screen.dart';
import '../screens/home_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String home = '/';
  static const String directory = '/directory';
  static const String notice = '/notice';
  static const String events = '/events';
  static const String news = '/news';
  static const String bus = '/bus';
  static const String calendar = '/calendar';
  static const String notificationSettings = '/notification-settings';
  static const String videos = '/videos';
  static const String campusMap = '/campus-map';
  static const String more = '/more';

  // Auth-gated
  static const String libraryLogin = '/library/login';
  static const String library = '/library';
  static const String medicalLogin = '/medical/login';
  static const String medical = '/medical';
  static const String studentServiceLogin = '/student-service/login';
  static const String studentService = '/student-service';
  static const String webmailLogin = '/webmail/login';
  static const String webmail = '/webmail';

  static Map<String, WidgetBuilder> all() => {
    splash: (_) => const SplashScreen(),
    home: (_) => const HomeScreen(),
    directory: (_) => const DirectoryScreen(embedded: false),
    notice: (_) => const NoticeScreen(embedded: false),
    events: (_) => const EventsScreen(),
    news: (_) => const NewsScreen(),
    bus: (_) => const BusScreen(),
    calendar: (_) => const CalendarScreen(),
    notificationSettings: (_) => const NotificationSettingsScreen(),
    videos: (_) => const VideosScreen(),
    campusMap: (_) => const CampusMapScreen(),
    more: (_) => const MoreScreen(embedded: false),
    libraryLogin: (_) => const LibraryLoginScreen(),
    library: (_) => const LibraryScreen(),
    medicalLogin: (_) => const MedicalLoginScreen(),
    medical: (_) => const MedicalScreen(),
    studentServiceLogin: (_) => const StudentServiceLoginScreen(),
    studentService: (_) => const StudentServiceScreen(),
    webmailLogin: (_) => const WebmailLoginScreen(),
    webmail: (_) => const WebmailScreen(),
  };
}