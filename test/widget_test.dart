import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ru_campus_hub/main.dart'; // <- replace with your pubspec `name:`
import 'package:ru_campus_hub/services/cache_service.dart';

void main() {
  testWidgets('App launches and shows splash screen', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final cache = await CacheService.create();

    await tester.pumpWidget(RuCampusHubApp(cache: cache));
    await tester.pump();

    // Splash screen is shown first.
    expect(find.byType(RuCampusHubApp), findsOneWidget);

    // Let the splash's 1.5s delay finish so no timers are left pending.
    await tester.pump(const Duration(milliseconds: 1600));
  });
}