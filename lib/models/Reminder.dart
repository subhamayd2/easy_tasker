import 'package:easy_tasker/utils.dart';
import 'package:flutter/material.dart';

class Reminder {
  int nId;
  String id;
  String title;
  String description;
  Color tag;
  TimeOfDay time;
  DateTime date;
  String timestamp;
  bool done;

  static string(Reminder r) {
    var s = "id#${r.id},title#${r.title},description#${r.description},";
    var tag = tagColors.indexOf(r.tag) ?? 0;
    s += "tag#$tag,time#${timeTo12hr(r.time, true)},";
    s +=
        "date#${formatDate(r.date, true)},timestamp#${r.timestamp},nId#${r.nId},done#${r.done}";
    return s;
  }

  static parse(String s) {
    var a = s.split(",");
    var r = Reminder()
      ..id = a[0].split("#")[1]
      ..title = a[1].split("#")[1]
      ..description = a[2].split("#")[1]
      ..tag = tagColors[int.parse(a[3].split("#")[1])]
      ..time = parseTime(a[4].split("#")[1])
      ..date = parseDate(a[5].split("#")[1])
      ..timestamp = a[6].split("#")[1]
      ..nId = int.parse(a[7].split("#")[1])
      ..done = bool.fromEnvironment(a[7].split("#")[1]);
    return r;
  }
}
