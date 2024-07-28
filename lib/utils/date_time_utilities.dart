import 'package:intl/intl.dart';

class DateTimeUtilities {
  static String eventTimeRange({
    required String startAt,
    required int durationMinutes,
  }) {
    // Parse the start time from the API
    DateTime startTime = DateTime.parse(startAt).toLocal();

    // Calculate the end time by adding the duration
    DateTime endTime = startTime.add(Duration(minutes: durationMinutes));

    // Define a date format for display
    DateFormat timeFormat = DateFormat('h:mm a');

    // Format the start and end times
    String startFormatted = timeFormat.format(startTime);
    String endFormatted = timeFormat.format(endTime);

    // Return the formatted time range
    return '$startFormatted - $endFormatted';
  }
}
