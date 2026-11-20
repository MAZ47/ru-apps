/// Library catalog + borrowed-book models. Mirrors the shape expected from
/// the future RU library API; mock data uses the same fields so swap-over
/// is seamless.
library;

class LibraryBook {
  final String id;
  final String title;
  final String author;
  final String category;
  final String callNumber;
  final bool available;

  const LibraryBook({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.callNumber,
    this.available = true,
  });

  factory LibraryBook.fromJson(Map<String, dynamic> json) => LibraryBook(
        id: json['id'].toString(),
        title: (json['title'] ?? '').toString(),
        author: (json['author'] ?? '').toString(),
        category: (json['category'] ?? 'General').toString(),
        callNumber: (json['call_number'] ?? '').toString(),
        available: json['available'] != false,
      );
}

class BorrowedBook {
  final String bookId;
  final String title;
  final String author;
  final DateTime borrowedOn;
  final DateTime dueDate;
  final double fine; // BDT if overdue

  const BorrowedBook({
    required this.bookId,
    required this.title,
    required this.author,
    required this.borrowedOn,
    required this.dueDate,
    this.fine = 0.0,
  });

  bool get isOverdue => DateTime.now().isAfter(dueDate);

  factory BorrowedBook.fromJson(Map<String, dynamic> json) => BorrowedBook(
        bookId: json['book_id'].toString(),
        title: (json['title'] ?? '').toString(),
        author: (json['author'] ?? '').toString(),
        borrowedOn: DateTime.parse(json['borrowed_on'].toString()),
        dueDate: DateTime.parse(json['due_date'].toString()),
        fine: (json['fine'] as num?)?.toDouble() ?? 0.0,
      );
}




