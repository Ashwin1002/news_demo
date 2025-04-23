import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String format([String pattern = 'dd/MM/yyyy']) =>
      DateFormat(pattern).format(this);

  int yearsDiff(DateTime other) {
    int yearDiff = other.year - year;

    // Adjust if the end date is before the start date's month/day
    if (other.month < month || (other.month == month && other.day < day)) {
      yearDiff--;
    }

    return yearDiff;
  }

  String toTimesAgo() {
    final dt = this;
    Duration diff = DateTime.now().toLocal().difference(dt);

    if (diff.inDays >= 365) {
      final val = diff.inDays % 365;
      return '$val year${_addPlural(val)} ago';
    }

    if (diff.inDays >= 30) {
      final value = diff.inDays % 30;
      return '$value month${_addPlural(value)} ago';
    }

    if (diff.inDays >= 7) {
      final value = diff.inDays % 7;
      return '$value week${_addPlural(value)} ago}';
    }
    if (diff.inDays >= 1) {
      return '${diff.inDays} day${_addPlural(diff.inDays)} ago';
    }
    if (diff.inHours >= 1) {
      return '${diff.inHours} ${diff.inHours == 1 ? 'hr' : 'hrs'} ago';
    }
    if (diff.inMinutes >= 1) {
      return '${diff.inMinutes} ${diff.inHours == 1 ? 'min' : 'mins'} ago';
    }
    if (diff.inSeconds >= 1) {
      return '${diff.inSeconds} secs ago';
    }
    return 'now';
  }
}

String _addPlural(int value) => value == 1 ? '' : 's';
