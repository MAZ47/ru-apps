import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_features.dart';
import '../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../widgets/drawer/drawer_row.dart';
import '../services/mock_data_service.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/app_header.dart';
import '../widgets/common/app_search_bar.dart';
import '../widgets/home/campus_alerts_card.dart';
import '../widgets/home/news_card.dart';
import '../widgets/home/quick_access_button.dart';
import '../widgets/side_drawer.dart';
import 'directory/directory_screen.dart';
import 'notice/notice_screen.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  void _handleDrawerNav(DrawerItem item) {
    // Bottom-nav tabs (Home / News / Directory / Notice)
    if (item.tabIndex != null) {
      setState(() => _navIndex = item.tabIndex!);
      return;
    }
    // Login-gated modules go to their login screen when signed out.
    final signedIn = context.read<AuthProvider>().isAuthenticated;
    final target = (item.requiresLogin && !signedIn) ? item.loginRoute : item.route;
    if (target != null) Navigator.of(context).pushNamed(target);
  }

  Future<void> _handleLogout() async {
    await context.read<AuthProvider>().logout();
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Logged out')));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _HomeDashboard(onSeeAllAlerts: () => setState(() => _navIndex = 3)),
      const _NewsTab(),
      const DirectoryScreen(embedded: true),
      const NoticeScreen(embedded: true),
      const _MoreTab(),
    ];

    return Scaffold(
      appBar: const HomeAppHeader(),
      drawer: AppSideDrawer(
        onNavigate: _handleDrawerNav,
        onLogout: _handleLogout,
      ),
      body: pages[_navIndex],
      bottomNavigationBar: AppBottomNav(
        currentIndex: _navIndex,
        onTap: (i) => setState(() => _navIndex = i),
      ),
    );
  }
}

/// Home tab: search, quick-access grid, alerts card, news carousel.
class _HomeDashboard extends StatelessWidget {
  final VoidCallback onSeeAllAlerts;
  const _HomeDashboard({required this.onSeeAllAlerts});

  @override
  Widget build(BuildContext context) {
    final news = MockDataService.instance.news;
    return ListView(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      children: [
        const Padding(
          padding: EdgeInsets.all(AppSpacing.md),
          child: AppSearchBar(placeholder: 'Search faculties, offices, courses…'),
        ),
        const _GridLabel('Easy Access'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 1.05,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: AppSpacing.sm,
            crossAxisSpacing: AppSpacing.sm,
            children: [
              for (final f in AppFeatures.easyAccess)
                QuickAccessButton(
                  label: f.label,
                  icon: f.icon,
                  onTap: () => _open(context, f),
                ),
            ],
          ),
        ),
        const _GridLabel('Login Required'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final f in AppFeatures.loginRequired)
                Expanded(
                  child: QuickAccessButton(
                    label: f.label,
                    icon: f.icon,
                    locked: true,
                    onTap: () => _open(context, f),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: CampusAlertsCard(onViewAll: onSeeAllAlerts),
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent News', style: AppTypography.sectionHeader),
              TextButton(
                onPressed: () {},
                child: Text('See all',
                    style: AppTypography.body.copyWith(color: AppColors.royalBlue)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: news.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, i) {
              final item = news[i];
              return NewsCard(title: item.title, tag: item.tag);
            },
          ),
        ),
      ],
    );
  }

  /// Opens a feature; login-required ones go to their login screen when signed out.
  void _open(BuildContext context, AppFeature f) {
    final signedIn = context.read<AuthProvider>().isAuthenticated;
    final target = (f.requiresLogin && !signedIn) ? f.loginRoute : f.route;
    if (target != null) Navigator.of(context).pushNamed(target);
  }
}

/// News tab: same items as the carousel, shown as a flat scrollable list.
class _NewsTab extends StatelessWidget {
  const _NewsTab();

  @override
  Widget build(BuildContext context) {
    final news = MockDataService.instance.news;
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: news.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, i) {
        final item = news[i];
        return NewsListRow(title: item.title, tag: item.tag);
      },
    );
  }
}

/// "More" tab — kept minimal in Home; the full version lives in
/// screens/more/more_screen.dart for standalone navigation.
class _MoreTab extends StatelessWidget {
  const _MoreTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: const [
        // Body intentionally light — the standalone More screen carries
        // the full navigation list. This tab is mostly a placeholder so
        // the bottom-nav stays at 5 items.
      ],
    );
  }
}
/// Small section title above a feature grid.
class _GridLabel extends StatelessWidget {
  final String text;
  const _GridLabel(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
        AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.sm),
    child: Text(text, style: AppTypography.sectionHeader),
  );
}