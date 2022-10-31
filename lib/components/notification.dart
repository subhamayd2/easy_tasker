import 'package:easy_tasker/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlutterLocalNotificationsPlugin notifications;

initializeNotifications(Future<dynamic> Function(String) callback) async {
  var android = AndroidInitializationSettings("@mipmap/launcher_icon");
  var ios = IOSInitializationSettings();
  var initSettings = InitializationSettings(android, ios);
  notifications = FlutterLocalNotificationsPlugin();
  await notifications.initialize(initSettings, onSelectNotification: callback);
}

void cancelNotification(nId) async {
  await notifications.cancel(nId);
}

void cancelAllNotification() async {
  await notifications.cancelAll();
}

Future<int> scheduleNofication(DateTime dateTime, String payload, String title,
    [String description]) async {
  var pref = await SharedPreferences.getInstance();
  int _id = pref.getInt(SP_KEY_NOTIFICATION_ID) ?? 0;
  var android = AndroidNotificationDetails(
    "easy_tracker_reminder",
    "Reminders",
    "Scheduled reminders. Turning this off is like not using the app.",
    enableLights: true,
    enableVibration: true,
    autoCancel: true,
    channelShowBadge: true,
    importance: Importance.High,
    playSound: true,
    priority: Priority.High,
    ticker: title,
    visibility: NotificationVisibility.Public,
    groupKey: NOTIFICATION_GROUP_ID,
  );
  var iOS = IOSNotificationDetails();
  var details = NotificationDetails(android, iOS);
  await notifications.schedule(
    _id,
    title,
    description,
    dateTime,
    details,
    payload: payload,
    androidAllowWhileIdle: true,
  );
  var nId = _id++;
  await pref.setInt(SP_KEY_NOTIFICATION_ID, _id);
  return nId;
}
