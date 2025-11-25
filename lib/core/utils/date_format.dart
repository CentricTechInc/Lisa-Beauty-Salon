import 'package:intl/intl.dart';

class DateFormatter {
  // Singleton instance
  static final DateFormatter _instance = DateFormatter._internal();

  factory DateFormatter() => _instance;

  DateFormatter._internal();

  // Common date formats
  static const String _defaultDateFormat = 'dd/MM/yyyy';
  static const String _fullDateFormat = 'EEEE, MMMM d, yyyy';
  static const String _shortDateFormat = 'MMM d, yyyy';
  static const String _dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String _iso8601Format = 'yyyy-MM-dd';

  /// Formats a DateTime object to a string with the specified format and locale
  String formatDate(
      DateTime? date, {
        String format = _defaultDateFormat,
        String? locale,
      }) {
    if (date == null) return '';
    try {
      final formatter = DateFormat(format, locale);
      return formatter.format(date);
    } catch (e) {
      return '';
    }
  }

  /// Formats DateTime to full date format (e.g., Monday, January 1, 2025)
  String formatFullDate(DateTime? date, {String? locale}) {
    return formatDate(date, format: _fullDateFormat, locale: locale);
  }

  /// Formats DateTime to short date format (e.g., Jan 1, 2025)
  String formatShortDate(DateTime? date, {String? locale}) {
    return formatDate(date, format: _shortDateFormat, locale: locale);
  }

  /// Formats DateTime to date and time format (e.g., 01/01/2025 14:30)
  String formatDateTime(DateTime? date, {String? locale}) {
    return formatDate(date, format: _dateTimeFormat, locale: locale);
  }

  /// Formats DateTime to ISO 8601 date format (e.g., 2025-01-01)
  String formatIso8601(DateTime? date, {String? locale}) {
    return formatDate(date, format: _iso8601Format, locale: locale);
  }

  /// Parses a date string to DateTime with the specified format
  DateTime? parseDate(
      String? dateString, {
        String format = _defaultDateFormat,
        String? locale,
      }) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      final formatter = DateFormat(format, locale);
      return formatter.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// Returns a relative time string (e.g., "2 days ago")
  String formatRelativeTime(
      DateTime? date, {
        String? locale,
      }) {
    if (date == null) return '';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays.abs() > 365) {
      return formatShortDate(date, locale: locale);
    } else if (difference.inDays.abs() > 30) {
      final months = (difference.inDays.abs() / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ${difference.isNegative ? 'from now' : 'ago'}';
    } else if (difference.inDays.abs() > 0) {
      return '${difference.inDays.abs()} day${difference.inDays.abs() > 1 ? 's' : ''} ${difference.isNegative ? 'from now' : 'ago'}';
    } else if (difference.inHours.abs() > 0) {
      return '${difference.inHours.abs()} hour${difference.inHours.abs() > 1 ? 's' : ''} ${difference.isNegative ? 'from now' : 'ago'}';
    } else if (difference.inMinutes.abs() > 0) {
      return '${difference.inMinutes.abs()} minute${difference.inMinutes.abs() > 1 ? 's' : ''} ${difference.isNegative ? 'from now' : 'ago'}';
    } else {
      return 'Just now';
    }
  }

  /// Checks if two dates are on the same day
  bool isSameDay(DateTime? date1, DateTime? date2) {
    if (date1 == null || date2 == null) return false;
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}