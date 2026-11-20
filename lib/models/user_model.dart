/// User identity and session info. Returned by the (future) auth API.
/// Keeping this in one place makes swapping providers (Firebase, custom
/// backend) a single-file change.
library;

class UserModel {
  final String id;
  final String name;
  final String email;
  final String studentId;
  final String? department;
  final String? faculty;
  final String? avatarUrl;
  final String role; // 'student', 'teacher', 'staff', 'admin'

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.studentId,
    required this.role,
    this.department,
    this.faculty,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      studentId: (json['student_id'] ?? json['studentId'] ?? '').toString(),
      role: (json['role'] ?? 'student').toString(),
      department: json['department']?.toString(),
      faculty: json['faculty']?.toString(),
      avatarUrl: json['avatar_url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'student_id': studentId,
        'role': role,
        if (department != null) 'department': department,
        if (faculty != null) 'faculty': faculty,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
      };
}




