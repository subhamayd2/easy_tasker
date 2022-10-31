import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_tasker/components/appbar.dart';
import 'package:easy_tasker/store/reminders/reminder.dart';
import 'package:flutter/material.dart';
import 'package:easy_tasker/completed_reminders.dart';
import 'package:easy_tasker/upcoming_reminders.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Home extends StatelessWidget {
  final reminderStore = ReminderStore.getInstance();

  @override
  Widget build(BuildContext context) {
    final isDark = DynamicTheme.of(context).brightness == Brightness.dark;
    return Observer(
      builder: (context) {
        int upcoming = reminderStore.reminders.where((r) => !r.done).length;
        int completed = reminderStore.reminders.length - upcoming;
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: Appbar(
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color:
                        isDark ? Colors.black54 : Colors.black12.withAlpha(25),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: TabBar(
                      unselectedLabelColor:
                          isDark ? Colors.white24 : Colors.grey,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).accentColor.withOpacity(0.5),
                            Theme.of(context).accentColor,
                          ],
                        ),
                      ),
                      tabs: [
                        Tab(
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.date_range),
                                SizedBox(width: 8),
                                Text("Upcoming"),
                                SizedBox(width: 5),
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Center(
                                    child: Text(
                                      upcoming > 9 ? "9+" : "$upcoming",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: FractionallySizedBox(
                            widthFactor: 0.8,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.date_range),
                                SizedBox(width: 8),
                                Text("Completed"),
                                SizedBox(width: 5),
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                  child: Center(
                                    child: Text(
                                      completed > 9 ? "9+" : "$completed",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                UpcomingReminders(),
                CompletedReminders(),
              ],
            ),
          ),
        );
      },
    );
  }
}
