class CampusEvent {
  final String title;
  final DateTime date;
  final String summary;
  final String type; // e.g. 'Conference', 'Registration Deadline'

  const CampusEvent({
    required this.title,
    required this.date,
    required this.summary,
    required this.type,
  });
}




