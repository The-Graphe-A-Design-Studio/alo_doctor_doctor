import 'package:intl/intl.dart';

class DateFormatter {
  String getVerboseDateTimeRepresentation(DateTime dateTime) {
    int calculateDifference(DateTime date) {
      DateTime now = DateTime.now();
      return DateTime(date.year, date.month, date.day)
          .difference(DateTime(now.year, now.month, now.day))
          .inDays;
    }

    DateTime now = DateTime.now();
    // DateTime justNow = DateTime.now().subtract(Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();

    // if (!localDateTime.difference(justNow).isNegative) {
    //   return 'Just now';
    // }
    // print(!localDateTime.isBefore(DateTime.now()));
    if (calculateDifference(localDateTime) == 1) {
      String roughTimeString = DateFormat('hh:mm').format(dateTime);

      return "Tomorrow, " + roughTimeString;
    } else if (calculateDifference(localDateTime) < 1) {
      // Today
      String roughTimeString = DateFormat('hh:mm').format(dateTime);

      if (localDateTime.day == now.day &&
          localDateTime.month == now.month &&
          localDateTime.year == now.year) {
        return "Today, " + roughTimeString;
      }

      // yesterday
      DateTime yesterday = now.subtract(Duration(days: 1));

      if (localDateTime.day == yesterday.day &&
          localDateTime.month == yesterday.month &&
          localDateTime.year == yesterday.year) {
        return 'Yesterday, ' + roughTimeString;
      }

      return '${DateFormat('MMM dd').format(dateTime)}, $roughTimeString';
    } else {
      String roughTimeString = DateFormat('hh:mm').format(dateTime);

      if (localDateTime.difference(now).inDays < 4) {
        String weekday = DateFormat('EEEE').format(localDateTime);

        return '$weekday, $roughTimeString';
      }
      return '${DateFormat('MMM dd').format(dateTime)}, $roughTimeString';
    }
  }
}
