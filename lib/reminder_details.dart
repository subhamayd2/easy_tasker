import 'package:easy_tasker/models/Reminder.dart';
import 'package:easy_tasker/utils.dart';
import 'package:flutter/material.dart';

class ReminderDetails extends StatelessWidget {
  final Function onDelete;
  final Reminder reminder;

  ReminderDetails({
    @required this.reminder,
    @required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 28.0, top: 20),
          child: Opacity(
            opacity: 0.5,
            child: Row(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.date_range, size: 16),
                    SizedBox(width: 3),
                    Text(
                      formatDate(reminder.date),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(width: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.timer, size: 16),
                    SizedBox(width: 3),
                    Text(
                      timeTo12hr(reminder.time),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        // SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: reminder.tag ?? Colors.transparent,
                width: 8.0,
              ),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            child: Opacity(
              opacity: 0.8,
              child: Text(
                reminder.title,
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
          child: Opacity(
            opacity: 0.8,
            child: Text(
              reminder.description ?? "",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(icon: Icon(Icons.edit), onPressed: () {}),
            SizedBox(width: 20),
            IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ],
    );
  }
}
