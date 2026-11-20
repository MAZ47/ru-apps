/// Academic-calendar event (semester dates, holidays, exam windows, etc.).
/// Distinct from [CampusEvent] which is one-off / public-facing events;
/// academic-calendar entries are official university-wide dates.
library;

class CalendarEvent {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final String category; // 'Semester', 'Exam', 'Holiday', 'Registration'

  const CalendarEvent({
    required this.id,
    required this.title,
    required this.startDate,
    this.endDate,
    required this.category,
  });

  bool get isMultiDay =>
      endDate != null && endDate!.difference(startDate).inDays > 0;

  factory CalendarEvent.fromJson(Map<String, dynamic> json) => CalendarEvent(
        id: json['id'].toString(),
        title: (json['title'] ?? '').toString(),
        startDate: DateTime.parse(json['start_date'].toString()),
        endDate: json['end_date'] != null
            ? DateTime.parse(json['end_date'].toString())
            : null,
        category: (json['category'] ?? 'General').toString(),
      );
}




