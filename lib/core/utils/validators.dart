/// Form validators for the login-required services. They return null when
/// the input is acceptable, otherwise a user-facing error message.
library;

class Validators {
  Validators._();

  /// Standard "required" rule used everywhere a field can't be empty.
  static String? required(String? value, [String fieldLabel = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldLabel is required';
    }
    return null;
  }

  /// Email-shaped validator (kept tolerant — most RU IDs are student numbers,
  /// not email addresses).
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    final re = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[A-Za-z]{2,}$');
    if (!re.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  /// RU portal credentials may be an email OR a student ID (e.g. 22108121012).
  static String? usernameOrStudentId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username or Student ID is required';
    }
    final trimmed = value.trim();
    final isEmail = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[A-Za-z]{2,}$').hasMatch(trimmed);
    final isStudentId = RegExp(r'^\d{6,14}$').hasMatch(trimmed);
    if (!isEmail && !isStudentId) {
      return 'Use your RU email or student ID';
    }
    return null;
  }

  /// Minimal password rule: at least 6 characters. The real backend will
  /// enforce its own policy; this just gives the user immediate feedback.
  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  /// Phone numbers are loosely validated — RU doesn't expose a strict format.
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return null; // optional by default
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8 || digits.length > 15) {
      return 'Enter a valid phone number';
    }
    return null;
  }
}




