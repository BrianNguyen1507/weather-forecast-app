class GetDateTime {
  String convertToMonthName(String inputDate) {
    List<String> parts = inputDate.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

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
    String monthName = monthNames[month - 1];

    return ' $day $monthName $year';
  }

  String formatDate(String dateTimeString) {
    String formattedDateTime =
        dateTimeString.substring(0, dateTimeString.indexOf("T"));
    return formattedDateTime;
  }

  bool isDateAfterNow(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();

    return date.isAfter(now);
  }
}
