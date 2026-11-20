/// Single source of placeholder content. The whole app can keep working
/// without a live backend by reading from here. Swap over to real services
/// by replacing the consumer — the data shapes match the models 1:1.
library;

import 'package:flutter/material.dart';

import '../models/bus_route_model.dart';
import '../models/calendar_event_model.dart';
import '../models/campus_event.dart';
import '../models/department.dart';
import '../models/library_model.dart';
import '../models/map_location_model.dart';
import '../models/medical_record_model.dart';
import '../models/news_model.dart';
import '../models/notice.dart';
import '../models/student_service_model.dart';
import '../models/video_model.dart';

class MockDataService {
  MockDataService();

  /// Static instance so existing screens can call `MockData.departments` /
  /// `MockData.notices` without a Provider lookup. Each property is built
  /// from the same underlying private lists, so we keep a single source
  /// of truth.
  static final MockDataService instance = MockDataService();

  // -------- Directory --------
  List<Department> get departments => _departments;

  static const List<Department> _departments = [
    // Faculties (representative subset of RU's 59 departments across 12 faculties)
    Department(
      name: 'Department of Botany',
      faculty: 'Life Sciences',
      description: 'Plant sciences, genetics and ecology research.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.royalBlue,
      icon: Icons.eco_outlined,
    ),
    Department(
      name: 'Department of Fine Arts',
      faculty: 'Fine Arts',
      description: 'Painting, sculpture, crafts and design studies.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.gold,
      icon: Icons.palette_outlined,
    ),
    Department(
      name: 'Department of Agronomy',
      faculty: 'Agriculture',
      description: 'Crop science and sustainable farming practices.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.crimson,
      icon: Icons.agriculture_outlined,
    ),
    Department(
      name: 'Department of Computer Science & Engineering',
      faculty: 'Engineering',
      description: 'Software, AI and systems engineering programs.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.royalBlue,
      icon: Icons.memory_outlined,
    ),
    Department(
      name: 'Department of Law',
      faculty: 'Law',
      description: 'Legal studies, jurisprudence and moot court.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.slate,
      icon: Icons.balance_outlined,
    ),
    Department(
      name: 'Department of Accounting & Information Systems',
      faculty: 'Business Studies',
      description: 'Accounting, finance and information systems.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.gold,
      icon: Icons.bar_chart_outlined,
    ),
    Department(
      name: 'Department of Sociology',
      faculty: 'Social Science',
      description: 'Society, culture and social structures.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.crimson,
      icon: Icons.groups_outlined,
    ),
    Department(
      name: 'Department of Applied Mathematics',
      faculty: 'Science',
      description: 'Pure and applied mathematics research.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.royalBlue,
      icon: Icons.functions_outlined,
    ),
    Department(
      name: 'Department of English',
      faculty: 'Arts',
      description: 'Literature, linguistics and language studies.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.slate,
      icon: Icons.menu_book_outlined,
    ),
    Department(
      name: 'Department of Geology & Mining',
      faculty: 'Earth & Environmental Sciences',
      description: 'Earth sciences and mineral resource studies.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.gold,
      icon: Icons.terrain_outlined,
    ),
    Department(
      name: 'Department of Fisheries',
      faculty: 'Fisheries',
      description: 'Aquaculture and fisheries management.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.crimson,
      icon: Icons.set_meal_outlined,
    ),
    Department(
      name: 'Department of Veterinary & Animal Sciences',
      faculty: 'Veterinary & Animal Sciences',
      description: 'Animal health, husbandry and veterinary care.',
      group: DirectoryGroup.faculty,
      badgeColor: BadgeColor.royalBlue,
      icon: Icons.pets_outlined,
    ),
    // Administrative Offices
    Department(
      name: 'Proctor Office',
      faculty: 'All',
      description: 'Campus discipline, safety and student conduct.',
      group: DirectoryGroup.administrative,
      badgeColor: BadgeColor.slate,
      icon: Icons.shield_outlined,
    ),
    Department(
      name: 'Transport Section',
      faculty: 'All',
      description: 'University bus routes and vehicle scheduling.',
      group: DirectoryGroup.administrative,
      badgeColor: BadgeColor.gold,
      icon: Icons.directions_bus_outlined,
    ),
    Department(
      name: 'ICT Cell',
      faculty: 'All',
      description: 'IT services, network and directory corrections.',
      group: DirectoryGroup.administrative,
      badgeColor: BadgeColor.royalBlue,
      icon: Icons.dns_outlined,
    ),
    Department(
      name: 'Central Library',
      faculty: 'All',
      description: 'Books, journals and digital archives.',
      group: DirectoryGroup.administrative,
      badgeColor: BadgeColor.crimson,
      icon: Icons.local_library_outlined,
    ),
  ];

  // -------- Notices --------
  List<Notice> get notices {
    final now = DateTime.now();
    return [
      Notice(title: 'Admission Test Result Published — 2025-26 Session', date: now.subtract(const Duration(hours: 3)), isUnread: true),
      Notice(title: 'Mid-Term Examination Routine Released', date: now.subtract(const Duration(days: 1)), isUnread: true),
      Notice(title: 'Notice: Campus Wi-Fi Maintenance This Weekend', date: now.subtract(const Duration(days: 2)), isUnread: false),
      Notice(title: 'Scholarship Application Deadline Extended', date: now.subtract(const Duration(days: 4)), isUnread: false),
      Notice(title: 'Convocation 2026 — Registration Now Open', date: now.subtract(const Duration(days: 6)), isUnread: false),
      Notice(title: 'Hall Seat Allotment Notice for New Students', date: now.subtract(const Duration(days: 9)), isUnread: false),
    ];
  }

  // -------- Events --------
  List<CampusEvent> get events {
    final now = DateTime.now();
    return [
      CampusEvent(
        title: 'International Conference on Applied Sciences',
        date: DateTime(now.year, now.month, now.day + 3),
        summary: 'Faculty of Science hosts researchers from across South Asia. Venue: Senate Bhaban.',
        type: 'Conference',
      ),
      CampusEvent(
        title: 'Registration Deadline — Spring Semester',
        date: DateTime(now.year, now.month, now.day + 7),
        summary: 'Last day to complete course registration via the student portal.',
        type: 'Registration Deadline',
      ),
      CampusEvent(
        title: 'Inter-Hall Cultural Festival',
        date: DateTime(now.year, now.month, now.day + 12),
        summary: 'Music, drama and art showcases across residential halls.',
        type: 'Cultural',
      ),
    ];
  }

  // -------- News (carousel + list) --------
  List<NewsModel> get news {
    final now = DateTime.now();
    return [
      NewsModel(
        id: '1',
        title: 'RU Researchers Publish in Nature Journal',
        summary: 'A team from the Faculty of Science co-authored a paper on climate-resilient crops.',
        tag: 'Research',
        publishedAt: now.subtract(const Duration(hours: 6)),
      ),
      NewsModel(
        id: '2',
        title: 'New Academic Building Inaugurated',
        summary: 'The five-storey complex houses the departments of CSE and EEE.',
        tag: 'Campus',
        publishedAt: now.subtract(const Duration(days: 1)),
      ),
      NewsModel(
        id: '3',
        title: 'RU Wins Inter-University Debate Championship',
        summary: 'The team beat 24 universities from across the country in the final round.',
        tag: 'Achievement',
        publishedAt: now.subtract(const Duration(days: 3)),
      ),
      NewsModel(
        id: '4',
        title: 'Vice-Chancellor Opens Research Grant Applications',
        summary: 'Applications open for the 2026 RU research grant cycle until end of month.',
        tag: 'Notice',
        publishedAt: now.subtract(const Duration(days: 5)),
      ),
    ];
  }

  // -------- Home quick-access --------
  List<Map<String, dynamic>> get quickAccess => [
        {'label': 'Central Library', 'icon': Icons.local_library_outlined, 'route': '/library'},
        {'label': 'Faculties', 'icon': Icons.school_outlined, 'route': '/directory'},
        {'label': 'Administration', 'icon': Icons.account_balance_outlined, 'route': '/directory'},
        {'label': 'Transport', 'icon': Icons.directions_bus_outlined, 'route': '/bus'},
        {'label': 'Halls', 'icon': Icons.holiday_village_outlined, 'route': '/campus-map'},
        {'label': 'Research', 'icon': Icons.biotech_outlined, 'route': '/news'},
      ];

  // -------- Bus routes --------
  List<BusRoute> get busRoutes => [
        BusRoute(
          id: 'r1',
          number: '1',
          name: 'Campus ↔ Talaimari',
          description: 'Main loop via Talaimari crossing — runs every 30 min.',
          stops: [
            const BusStop(name: 'Campus Gate', eta: '07:00', order: 1),
            const BusStop(name: 'Senate Bhaban', eta: '07:08', order: 2),
            const BusStop(name: 'Central Library', eta: '07:14', order: 3),
            const BusStop(name: 'Talaimari Crossing', eta: '07:30', order: 4),
            const BusStop(name: 'Shaheed Minar', eta: '07:38', order: 5),
          ],
        ),
        BusRoute(
          id: 'r2',
          number: '2',
          name: 'Campus ↔ Padma Residential',
          description: 'Express service to Padma Residential Hall.',
          stops: [
            const BusStop(name: 'Campus Gate', eta: '07:15', order: 1),
            const BusStop(name: 'Motihar', eta: '07:25', order: 2),
            const BusStop(name: 'Padma Hall Gate', eta: '07:35', order: 3),
          ],
        ),
        BusRoute(
          id: 'r3',
          number: '3',
          name: 'Campus ↔ Rajshahi Town',
          description: 'Connects campus to the main town commercial area.',
          stops: [
            const BusStop(name: 'Campus Gate', eta: '08:00', order: 1),
            const BusStop(name: 'Binodpur Bypass', eta: '08:15', order: 2),
            const BusStop(name: 'New Market', eta: '08:30', order: 3),
            const BusStop(name: 'Rajshahi Court', eta: '08:40', order: 4),
          ],
        ),
      ];

  // -------- Academic calendar --------
  List<CalendarEvent> get calendarEvents {
    final now = DateTime.now();
    return [
      CalendarEvent(
        id: 'c1',
        title: 'Spring Semester Begins',
        startDate: DateTime(now.year, now.month, now.day + 5),
        category: 'Semester',
      ),
      CalendarEvent(
        id: 'c2',
        title: 'Mid-Term Examination',
        startDate: DateTime(now.year, now.month, now.day + 25),
        endDate: DateTime(now.year, now.month, now.day + 30),
        category: 'Exam',
      ),
      CalendarEvent(
        id: 'c3',
        title: 'National Holiday — Independence Day',
        startDate: DateTime(now.year, 3, 26),
        category: 'Holiday',
      ),
      CalendarEvent(
        id: 'c4',
        title: 'Registration Deadline',
        startDate: DateTime(now.year, now.month, now.day + 7),
        category: 'Registration',
      ),
      CalendarEvent(
        id: 'c5',
        title: 'Final Examination',
        startDate: DateTime(now.year, now.month, now.day + 70),
        endDate: DateTime(now.year, now.month, now.day + 80),
        category: 'Exam',
      ),
    ];
  }

  // -------- Videos --------
  List<VideoModel> get videos {
    final now = DateTime.now();
    return [
      VideoModel(
        id: 'v1',
        title: 'Campus Tour — University of Rajshahi',
        description: 'A walk through the historic campus.',
        thumbnailUrl: '',
        videoUrl: 'https://ru.ac.bd/media/videos/campus-tour',
        duration: const Duration(minutes: 4, seconds: 12),
        publishedAt: now.subtract(const Duration(days: 30)),
      ),
      VideoModel(
        id: 'v2',
        title: 'Convocation 2025 Highlights',
        description: 'Highlights from the 2025 convocation ceremony.',
        thumbnailUrl: '',
        videoUrl: 'https://ru.ac.bd/media/videos/convocation-2025',
        duration: const Duration(minutes: 6, seconds: 40),
        publishedAt: now.subtract(const Duration(days: 60)),
      ),
      VideoModel(
        id: 'v3',
        title: 'Research at RU — A Short Documentary',
        description: 'Faculty and students talk about ongoing research.',
        thumbnailUrl: '',
        videoUrl: 'https://ru.ac.bd/media/videos/research-doc',
        duration: const Duration(minutes: 8, seconds: 5),
        publishedAt: now.subtract(const Duration(days: 90)),
      ),
    ];
  }

  // -------- Campus map locations --------
  List<MapLocation> get mapLocations => [
        MapLocation(
          id: 'm1',
          name: 'Senate Bhaban',
          category: 'Academic',
          latitude: 24.3635,
          longitude: 88.6265,
          description: 'Main administrative and academic building.',
        ),
        MapLocation(
          id: 'm2',
          name: 'Central Library',
          category: 'Facility',
          latitude: 24.3648,
          longitude: 88.6272,
          description: 'Houses over 300,000 books and digital archives.',
        ),
        MapLocation(
          id: 'm3',
          name: 'Medical Center',
          category: 'Facility',
          latitude: 24.3650,
          longitude: 88.6259,
          description: 'On-campus medical services for students and staff.',
        ),
        MapLocation(
          id: 'm4',
          name: 'Padma Residential Hall',
          category: 'Hall',
          latitude: 24.3662,
          longitude: 88.6281,
          description: 'One of the largest residential halls on campus.',
        ),
        MapLocation(
          id: 'm5',
          name: 'ICT Cell',
          category: 'Admin',
          latitude: 24.3642,
          longitude: 88.6268,
          description: 'IT services and campus network operations.',
        ),
      ];

  // -------- Library catalog (mock) --------
  List<LibraryBook> get libraryCatalog => [
        const LibraryBook(
          id: 'b1',
          title: 'Introduction to Algorithms',
          author: 'Cormen, Leiserson, Rivest, Stein',
          category: 'Computer Science',
          callNumber: '004.0151 COR',
          available: true,
        ),
        const LibraryBook(
          id: 'b2',
          title: 'Organic Chemistry',
          author: 'Morrison & Boyd',
          category: 'Chemistry',
          callNumber: '547 MOR',
          available: false,
        ),
        const LibraryBook(
          id: 'b3',
          title: 'A Brief History of Time',
          author: 'Stephen Hawking',
          category: 'Physics',
          callNumber: '523.1 HAW',
          available: true,
        ),
        const LibraryBook(
          id: 'b4',
          title: 'Constitutional Law of Bangladesh',
          author: 'M. Rafiqul Islam',
          category: 'Law',
          callNumber: '342.549 ISL',
          available: true,
        ),
      ];

  List<BorrowedBook> get borrowedBooks {
    final now = DateTime.now();
    return [
      BorrowedBook(
        bookId: 'b2',
        title: 'Organic Chemistry',
        author: 'Morrison & Boyd',
        borrowedOn: now.subtract(const Duration(days: 10)),
        dueDate: now.subtract(const Duration(days: 2)),
        fine: 20.0,
      ),
      BorrowedBook(
        bookId: 'b5',
        title: 'Engineering Mathematics',
        author: 'H. K. Dass',
        borrowedOn: now.subtract(const Duration(days: 3)),
        dueDate: now.add(const Duration(days: 11)),
      ),
    ];
  }

  // -------- Medical records (mock) --------
  List<MedicalRecord> get medicalRecords {
    final now = DateTime.now();
    return [
      MedicalRecord(
        id: 'med1',
        visitDate: now.subtract(const Duration(days: 30)),
        doctor: 'Dr. Kamrul Hasan',
        diagnosis: 'Seasonal viral fever',
        prescription: 'Paracetamol 500mg, rest, hydration.',
        notes: 'Recovered within 5 days.',
      ),
      MedicalRecord(
        id: 'med2',
        visitDate: now.subtract(const Duration(days: 120)),
        doctor: 'Dr. Salma Akter',
        diagnosis: 'Routine health check-up',
        prescription: 'Multivitamin (30 days).',
      ),
    ];
  }

  // -------- Student service (mock) --------
  List<StudentResult> get studentResults => [
        StudentResult(
          semester: 'Fall 2024',
          cgpa: 3.72,
          totalCredits: 18,
          courses: const [
            StudentCourse(code: 'CSE301', title: 'Data Structures', instructor: 'Dr. M. Ali', credits: 3.0, grade: 'A'),
            StudentCourse(code: 'CSE303', title: 'Operating Systems', instructor: 'Dr. R. Khan', credits: 3.0, grade: 'A-'),
            StudentCourse(code: 'MAT301', title: 'Linear Algebra', instructor: 'Dr. S. Hossain', credits: 3.0, grade: 'A+'),
            StudentCourse(code: 'ENG301', title: 'Technical Writing', instructor: 'Ms. F. Rahman', credits: 2.0, grade: 'B+'),
          ],
        ),
        StudentResult(
          semester: 'Spring 2024',
          cgpa: 3.65,
          totalCredits: 16,
          courses: const [
            StudentCourse(code: 'CSE201', title: 'Discrete Mathematics', instructor: 'Dr. M. Ali', credits: 3.0, grade: 'A-'),
            StudentCourse(code: 'CSE203', title: 'Object-Oriented Programming', instructor: 'Dr. S. Hossain', credits: 3.0, grade: 'A'),
            StudentCourse(code: 'PHY201', title: 'Physics II', instructor: 'Dr. R. Khan', credits: 3.0, grade: 'B+'),
          ],
        ),
      ];
}