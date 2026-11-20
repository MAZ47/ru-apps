/// News article shown in the carousel + News tab.
library;

class NewsModel {
  final String id;
  final String title;
  final String summary;
  final String tag; // 'Research', 'Campus', 'Achievement', etc.
  final String? imageUrl;
  final DateTime publishedAt;
  final String? sourceUrl;

  const NewsModel({
    required this.id,
    required this.title,
    required this.summary,
    required this.tag,
    required this.publishedAt,
    this.imageUrl,
    this.sourceUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json['id'].toString(),
        title: (json['title'] ?? '').toString(),
        summary: (json['summary'] ?? '').toString(),
        tag: (json['tag'] ?? 'Campus').toString(),
        imageUrl: json['image_url']?.toString(),
        publishedAt: DateTime.parse(json['published_at'].toString()),
        sourceUrl: json['source_url']?.toString(),
      );
}




