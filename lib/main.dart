import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/events_provider.dart';
import 'providers/news_provider.dart';
import 'providers/notice_provider.dart';
import 'providers/settings_provider.dart';
import 'routes/app_routes.dart';
import 'services/api_service.dart';
import 'services/auth_service.dart';
import 'services/cache_service.dart';
import 'services/mock_data_service.dart';
import 'services/scraper_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cache = await CacheService.create();
  runApp(RuCampusHubApp(cache: cache));
}

class RuCampusHubApp extends StatelessWidget {
  final CacheService cache;
  const RuCampusHubApp({super.key, required this.cache});

  @override
  Widget build(BuildContext context) {
    final mock = MockDataService.instance;
    final scraper = ScraperService(mock);
    final authService = AuthService(ApiService());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthProvider(authService)..bootstrap()),
        ChangeNotifierProvider(create: (_) => NoticeProvider(scraper)),
        ChangeNotifierProvider(create: (_) => NewsProvider(scraper)),
        ChangeNotifierProvider(create: (_) => EventsProvider(scraper, mock)),
        ChangeNotifierProvider(
            create: (_) => SettingsProvider(cache)..bootstrap()),
      ],
      child: MaterialApp(
        title: 'RU Campus Hub',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.all(),
      ),
    );
  }
}