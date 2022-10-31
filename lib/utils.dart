import 'package:flutter/material.dart';

final months = [
  null,
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sept",
  "Oct",
  "Nov",
  "Dec"
];

final weekdays = [null, "Mon", "Tue", "Wed", "Thurs", "Fri", "Sat", "Sun"];

final tagColors = [
  null,
  Colors.amberAccent,
  Colors.redAccent,
  Colors.blueAccent,
  Colors.greenAccent,
  Colors.orangeAccent,
  Colors.deepPurpleAccent,
  Colors.indigoAccent,
  Colors.pinkAccent,
];

bool reminderDone(DateTime date, TimeOfDay time) {
  DateTime merged = mergeDateTime(date, time);
  int diff = merged.compareTo(DateTime.now());
  return diff < 0;
}

DateTime mergeDateTime(DateTime date, TimeOfDay time) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}

String timeTo12hr(TimeOfDay time, [alt = false]) {
  if (time == null) {
    return "Select time";
  }
  int h = time.hour;
  int m = time.minute;
  if (alt) {
    return "$h:$m";
  }

  String hr;
  String a = "am";
  if (h == 0) {
    hr = "12";
  } else if (h <= 12) {
    hr = pad(h);
  } else {
    hr = "${h - 12}";
    a = "pm";
  }
  return "$hr:${pad(m)} $a";
}

TimeOfDay parseTime(String t) {
  var tt = t.split(":");
  return TimeOfDay.now()
      .replacing(hour: int.parse(tt[0]), minute: int.parse(tt[1]));
}

DateTime parseDate(String d) {
  return DateTime.parse(d);
}

String formatDate(DateTime date, [alt = false]) {
  if (date == null) {
    return "Select date";
  }
  if (alt) {
    return "${date.year}${pad(date.month)}${pad(date.day)}";
  }
  return "${weekdays[date.weekday]}, ${pad(date.day)} ${months[date.month]}, ${date.year}";
}

String pad(int num) {
  if (num < 10) {
    return "0$num";
  }
  return "$num";
}
