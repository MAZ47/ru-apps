/// Student-service models: profile, course, and result entry.
/// Grouped because the Student Service tab renders all three.
library;

class StudentCourse {
  final String code;
  final String title;
  final String instructor;
  final double credits;
  final String grade; // 'A+', 'A', 'B+', 'B', ...

  const StudentCourse({
    required this.code,
    required this.title,
    required this.instructor,
    required this.credits,
    required this.grade,
  });

  factory StudentCourse.fromJson(Map<String, dynamic> json) => StudentCourse(
        code: (json['code'] ?? '').toString(),
        title: (json['title'] ?? '').toString(),
        instructor: (json['instructor'] ?? '').toString(),
        credits: (json['credits'] as num?)?.toDouble() ?? 0.0,
        grade: (json['grade'] ?? '').toString(),
      );
}

class StudentResult {
  final String semester;
  final double cgpa;
  final int totalCredits;
  final List<StudentCourse> courses;

  const StudentResult({
    required this.semester,
    required this.cgpa,
    required this.totalCredits,
    required this.courses,
  });

  factory StudentResult.fromJson(Map<String, dynamic> json) {
    final list = (json['courses'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .map(StudentCourse.fromJson)
        .toList();
    return StudentResult(
      semester: (json['semester'] ?? '').toString(),
      cgpa: (json['cgpa'] as num?)?.toDouble() ?? 0.0,
      totalCredits: (json['total_credits'] as num?)?.toInt() ?? 0,
      courses: list,
    );
  }
}




