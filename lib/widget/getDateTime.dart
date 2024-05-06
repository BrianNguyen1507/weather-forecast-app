import 'package:intl/intl.dart';

class GetDateTime {
  String convertFromEpochToMonthName(int epoch) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);

    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    String monthName = monthNames[dateTime.month - 1];

    String formattedDate = '${dateTime.day} $monthName ${dateTime.year}';

    return formattedDate;
  }

  String convertEpochToDateString(int epoch) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String formatCurrentDate() {
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('EEEE').format(now);

    return formattedDate;
  }
}
