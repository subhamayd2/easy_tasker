import 'package:easy_tasker/components/appbar.dart';
import 'package:easy_tasker/components/notification.dart';
import 'package:easy_tasker/components/textfield.dart';
import 'package:easy_tasker/constants.dart';
import 'package:easy_tasker/exception/EmptyError.dart';
import 'package:easy_tasker/models/Reminder.dart';
import 'package:easy_tasker/store/reminders/reminder.dart';
import 'package:easy_tasker/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddReminder extends StatefulWidget {
  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final reminderStore = ReminderStore.getInstance();

  Color selectedTag;
  TimeOfDay time;
  DateTime date;

  void onTagSelected(Color tag) {
    setState(() {
      selectedTag = tag;
    });
  }

  void onTimeSelected(TimeOfDay _time) {
    setState(() {
      time = _time;
    });
  }

  void onDateSelected(DateTime _date) {
    setState(() {
      date = _date;
    });
  }

  void onAdd() {
    try {
      var rem = Reminder();
      rem.id = Uuid().v4();
      rem.timestamp = "${DateTime.now().microsecondsSinceEpoch}";
      rem.title = _titleController.text.trim().isEmpty
          ? throw EmptyError(message: "Title cannot be empty")
          : _titleController.text.trim();
      rem.description = _descController.text.trim();
      rem.date = date == null
          ? throw EmptyError(message: "Date cannot be empty")
          : date;
      rem.time = time == null
          ? throw EmptyError(message: "Time cannot be empty")
          : time;
      rem.tag = selectedTag;
      rem.done = false;

      SharedPreferences.getInstance().then((pref) {
        var rems = pref.getStringList(SP_KEY_REMINDERS) ?? [];
        DateTime dateTime = mergeDateTime(rem.date, rem.time);
        scheduleNofication(dateTime, rem.id, rem.title, rem.description)
            .then((nId) {
          rem.nId = nId;
          rems.insert(0, Reminder.string(rem));
          pref.setStringList(SP_KEY_REMINDERS, rems);
          reminderStore.addReminder(rem);
          Navigator.of(context).pop(true);
        });
      });
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Appbar(),
      body: SingleChildScrollView(
        // padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 25.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: UITextField(
                controller: _titleController,
                label: "Title",
                fontSize: 30,
              ),
            ),
            Divider(),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: UITextField(
                  controller: _descController, label: "Description"),
            ),
            Divider(),
            SizedBox(height: 25.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now().subtract(
                          Duration(days: 1),
                        ),
                        lastDate: DateTime.now().add(Duration(days: 90)),
                        initialDate: DateTime.now(),
                      ).then((date) {
                        if (date != null) {
                          onDateSelected(date);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Opacity(
                            opacity: 0.4,
                            child: Icon(Icons.date_range),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              formatDate(date),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((time) {
                        if (time != null) {
                          onTimeSelected(time);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Opacity(
                            opacity: 0.4,
                            child: Icon(Icons.timer),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              timeTo12hr(time),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Tags"),
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Wrap(
                          spacing: 8.0, // gap between adjacent chips
                          runSpacing: 8.0,
                          children: getTags(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAdd,
        label: Text("Add Reminder"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Widget> getTags() {
    final colors = tagColors.skip(1);
    var tags = <Widget>[];
    colors.forEach((c) {
      final isSelected = c == selectedTag;
      tags.add(
        GestureDetector(
          onTap: () {
            onTagSelected(isSelected ? null : c);
          },
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(18),
            ),
            child: isSelected
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.black12,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      );
    });
    return tags;
  }
}
