import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../models/news_model.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/home/news_card.dart';

class NewsScreen extends StatelessWidget {
  final bool embedded;
  const NewsScreen({super.key, this.embedded = false});

  static const _categories = ['All', 'Campus', 'Research', 'Sports', 'Notices'];

  @override
  Widget build(BuildContext context) {
    final List<NewsModel> all = MockDataService.instance.news;
    final body = Column(
      children: [
        SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
            itemBuilder: (context, i) {
              final selected = i == 0;
              return Chip(
                label: Text(_categories[i]),
                backgroundColor: selected ? AppColors.royalBlue : AppColors.white,
                labelStyle: AppTypography.label.copyWith(
                  color: selected ? AppColors.white : AppColors.slateGrey,
                ),
                side: BorderSide(
                  color: selected ? AppColors.royalBlue : AppColors.chipUnselectedBorder,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: all.isEmpty
              ? const EmptyState(message: 'No news yet.')
              : ListView.separated(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            itemCount: all.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (context, i) {
              if (i == 0) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: SizedBox(
                    height: 160,
                    child: NewsCard(title: all.first.title, tag: all.first.tag),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: NewsListRow(title: all[i].title, tag: all[i].tag),
              );
            },
          ),
        ),
      ],
    );

    if (embedded) return body;
    return Scaffold(
      appBar: const AppHeader(title: AppStrings.drawerNews, showBackButton: true),
      body: body,
    );
  }
}