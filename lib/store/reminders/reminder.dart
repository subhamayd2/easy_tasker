import 'package:easy_tasker/models/Reminder.dart';
import 'package:mobx/mobx.dart';

part 'reminder.g.dart';

class _ReminderStore = _ReminderBase with _$_ReminderStore;

class ReminderStore {
  static _ReminderStore reminderStore;
  static _ReminderStore getInstance() {
    if (ReminderStore.reminderStore == null) {
      ReminderStore.reminderStore = _ReminderStore();
    }
    return ReminderStore.reminderStore;
  }
}

abstract class _ReminderBase with Store {
  @observable
  ObservableList<Reminder> reminders = ObservableList();

  @action
  void addReminder(Reminder r) {
    reminders.insert(0, r);
  }

  @action
  int removeReminder(Reminder rem) {
    int pos = reminders.indexOf(rem);
    reminders.remove(rem);
    return pos;
  }

  @action
  void updateReminder(Reminder r) {
    int pos = reminders.indexOf(r);
    reminders[pos] = r;
  }
}
