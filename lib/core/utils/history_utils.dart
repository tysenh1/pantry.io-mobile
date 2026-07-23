import 'package:intl/intl.dart';

bool isSameDay(DateTime currentDate, DateTime previousDate) {
  return currentDate.year == previousDate.year && currentDate.month == previousDate.month && currentDate.day == previousDate.day;
}

String formatDate(DateTime date) {
    final now = DateTime.now();
    if (isSameDay(date, now)) return 'Today';
    if (isSameDay(date, now.subtract(const Duration(days: 1)))) return 'Yesterday';

    final String month = DateFormat('MMMM').format(date);
    final int day = date.day;
    final int year = date.year;

    String suffix = 'th';
    if (!(day >= 11 && day <= 13)) {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
      }
    }

    return '$month $day$suffix, $year';
  }