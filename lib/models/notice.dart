class Notice {
  final String title;
  final DateTime date;
  final bool isUnread;
  final String category;

  const Notice({
    required this.title,
    required this.date,
    required this.isUnread,
    this.category = 'General',
  });
}




