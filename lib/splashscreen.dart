import 'package:easy_tasker/components/notification.dart';
import 'package:easy_tasker/constants.dart';
import 'package:easy_tasker/models/Reminder.dart';
import 'package:easy_tasker/store/reminders/reminder.dart';
import 'package:easy_tasker/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var reminder = ReminderStore.getInstance();
    SharedPreferences.getInstance().then((pref) {
      var sList = pref.getStringList(SP_KEY_REMINDERS) ?? [];
      var newList = <String>[];
      sList.reversed.forEach((s) {
        Reminder rem = Reminder.parse(s);
        var newStr = s;
        if (reminderDone(rem.date, rem.time)) {
          rem.done = true;
          newStr = Reminder.string(rem);
        }
        newList.add(newStr);
        reminder.addReminder(rem);
      });

      pref.setStringList(SP_KEY_REMINDERS, newList);

      Future.delayed(Duration(seconds: 2)).then((_) {
        Navigator.of(context).pushReplacementNamed("/home");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 150,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
