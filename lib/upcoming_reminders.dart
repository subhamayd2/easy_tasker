import 'dart:ui';
import 'package:easy_tasker/components/list_row.dart';
import 'package:easy_tasker/components/no_items.dart';
import 'package:easy_tasker/components/notification.dart';
import 'package:easy_tasker/components/tag_filter.dart';
import 'package:easy_tasker/constants.dart';
import 'package:easy_tasker/models/Reminder.dart';
import 'package:easy_tasker/reminder_details.dart';
import 'package:easy_tasker/store/reminders/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpcomingReminders extends StatefulWidget {
  @override
  _UpcomingRemindersState createState() => _UpcomingRemindersState();
}

class _UpcomingRemindersState extends State<UpcomingReminders> {
  final reminderStore = ReminderStore.getInstance();
  ObservableList<Reminder> reminders;

  String currItemShowing;
  Color _selectedColor;
  bool colorFilterOpen = false;

  void _changeFilterState(Color filterColor) {
    var filteredRem = filterColor == null
        ? reminderStore.reminders
        : ObservableList.of(reminderStore.reminders
            .where((r) => !r.done && r.tag == filterColor));
    setState(() {
      reminders = filteredRem;
      _selectedColor = filterColor;
    });
  }

  void toggleColorFilter() {
    setState(() {
      colorFilterOpen = !this.colorFilterOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    initNotification();
    updateLocalReminders();
  }

  updateLocalReminders() {
    setState(() {
      reminders =
          ObservableList.of(reminderStore.reminders.where((r) => !r.done));
    });
  }

  initNotification() async {
    await initializeNotifications(handleNavigation);
  }

  showDetails(Reminder item) async {
    if (currItemShowing != null) {
      return;
    }
    currItemShowing = item.id;
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, __, ___) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ReminderDetails(
                reminder: item,
                onDelete: () {
                  Navigator.pop(context);
                  removeReminder(item);
                },
              ),
            ),
          );
        },
        barrierDismissible: true,
        opaque: false,
      ),
    );
    currItemShowing = null;
  }

  Future<dynamic> handleNavigation(String payload) async {
    var r = reminderStore.reminders
        .singleWhere((rem) => rem.id == payload && !rem.done);
    if (r == null) {
      return;
    }
    r.done = true;
    reminderStore.updateReminder(r);
    updateLocalReminders();
    await showDetails(r);
  }

  void addReminder() {
    Navigator.of(context).pushNamed("/add").then((success) {
      if (success ?? false) {
        updateLocalReminders();
      }
    });
  }

  void removeReminder(rem) {
    updateLocalReminders();
    reminderStore.removeReminder(rem);
    SharedPreferences.getInstance().then((pref) {
      var rems = pref.getStringList(SP_KEY_REMINDERS);
      rems.remove(Reminder.string(rem));
      pref.setStringList(SP_KEY_REMINDERS, rems);
    });
    cancelNotification(rem.nId);
  }

  @override
  Widget build(BuildContext context) {
    double filterContainerWidth = MediaQuery.of(context).size.width - 180;
    return Scaffold(
      body: Observer(
        builder: (_) {
          return Stack(
            children: <Widget>[
              NoItem(
                opacity: reminders.isEmpty ? 1 : 0,
                text: "Start adding reminders!",
              ),
              Column(
                children: <Widget>[
                  TagFilter(
                    selectedColor: _selectedColor,
                    colorFilterOpen: colorFilterOpen,
                    filterContainerWidth: filterContainerWidth,
                    changeFilterState: _changeFilterState,
                    toggleColorFilter: toggleColorFilter,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(15),
                      itemCount: reminders.length,
                      itemBuilder: (_, index) {
                        final item = reminders[index];
                        return ListRow(
                          item: item,
                          showDetails: showDetails,
                          removeReminder: removeReminder,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addReminder,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
