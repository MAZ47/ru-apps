/// Campus map pin — used by the Campus Map screen.
library;

class MapLocation {
  final String id;
  final String name;
  final String category; // 'Academic', 'Admin', 'Hall', 'Facility'
  final double latitude;
  final double longitude;
  final String description;

  const MapLocation({
    required this.id,
    required this.name,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.description,
  });

  factory MapLocation.fromJson(Map<String, dynamic> json) => MapLocation(
        id: json['id'].toString(),
        name: (json['name'] ?? '').toString(),
        category: (json['category'] ?? 'Campus').toString(),
        latitude: (json['latitude'] as num).toDouble(),
        longitude: (json['longitude'] as num).toDouble(),
        description: (json['description'] ?? '').toString(),
      );
}




