/// Campus video entry (used in the Videos tab). Real source will be
/// ru.ac.bd/media or a YouTube playlist — both reduce to the same shape.
library;

class VideoModel {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final Duration duration;
  final DateTime publishedAt;

  const VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.duration,
    required this.publishedAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json['id'].toString(),
        title: (json['title'] ?? '').toString(),
        description: (json['description'] ?? '').toString(),
        thumbnailUrl: (json['thumbnail_url'] ?? '').toString(),
        videoUrl: (json['video_url'] ?? '').toString(),
        duration: Duration(seconds: (json['duration_seconds'] as num?)?.toInt() ?? 0),
        publishedAt: DateTime.parse(json['published_at'].toString()),
      );
}




