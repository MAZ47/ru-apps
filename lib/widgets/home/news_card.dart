import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

/// Horizontal-scroll photo card used in Home's "Recent News" carousel.
class NewsCard extends StatelessWidget {
  final String title;
  final String tag;

  const NewsCard({super.key, required this.title, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.gridRadius),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.royalBlue, Color(0xFF12305F)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: AppSpacing.sm,
            left: AppSpacing.sm,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(6)),
              child: Text(tag, style: AppTypography.label.copyWith(color: Colors.black87, fontSize: 10)),
            ),
          ),
          Positioned(
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            bottom: AppSpacing.sm,
            child: Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

/// Flat-list row version of a news item, used on the "News" tab.
class NewsListRow extends StatelessWidget {
  final String title;
  final String tag;

  const NewsListRow({super.key, required this.title, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 90),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.gridRadius),
        boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 6, offset: Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: AppColors.royalBlue),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tag, style: AppTypography.label.copyWith(color: AppColors.crimsonRed)),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.cardTitle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





