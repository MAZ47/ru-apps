import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../models/video_model.dart';
import '../../services/mock_data_service.dart';
import '../../widgets/app_header.dart';
import '../../widgets/empty_state.dart';

class VideosScreen extends StatelessWidget {
  final bool embedded;
  const VideosScreen({super.key, this.embedded = false});

  @override
  Widget build(BuildContext context) {
    final videos = MockDataService.instance.videos;
    final body = videos.isEmpty
        ? const EmptyState(message: 'No videos available yet.')
        : GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.78,
      ),
      itemCount: videos.length,
      itemBuilder: (context, i) => _VideoCard(video: videos[i]),
    );

    if (embedded) return body;
    return Scaffold(
      appBar: const AppHeader(title: 'Videos', showBackButton: true),
      body: body,
    );
  }
}

class _VideoCard extends StatelessWidget {
  final VideoModel video;
  const _VideoCard({required this.video});

  static String _formatDuration(Duration d) {
    final m = d.inMinutes;
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.gridRadius),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.gridRadius)),
              gradient: LinearGradient(
                colors: [AppColors.royalBlue, AppColors.crimsonRed],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Icon(Icons.play_circle_fill, color: AppColors.white, size: 48),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.title,
                  style: AppTypography.body.copyWith(
                      fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  _formatDuration(video.duration),
                  style: AppTypography.label,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}