// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$_ReminderStore on _ReminderBase, Store {
  final _$remindersAtom = Atom(name: '_ReminderBase.reminders');

  @override
  ObservableList<Reminder> get reminders {
    _$remindersAtom.context.enforceReadPolicy(_$remindersAtom);
    _$remindersAtom.reportObserved();
    return super.reminders;
  }

  @override
  set reminders(ObservableList<Reminder> value) {
    _$remindersAtom.context.conditionallyRunInAction(() {
      super.reminders = value;
      _$remindersAtom.reportChanged();
    }, _$remindersAtom, name: '${_$remindersAtom.name}_set');
  }

  final _$_ReminderBaseActionController =
      ActionController(name: '_ReminderBase');

  @override
  void addReminder(Reminder r) {
    final _$actionInfo = _$_ReminderBaseActionController.startAction();
    try {
      return super.addReminder(r);
    } finally {
      _$_ReminderBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int removeReminder(Reminder rem) {
    final _$actionInfo = _$_ReminderBaseActionController.startAction();
    try {
      return super.removeReminder(rem);
    } finally {
      _$_ReminderBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateReminder(Reminder r) {
    final _$actionInfo = _$_ReminderBaseActionController.startAction();
    try {
      return super.updateReminder(r);
    } finally {
      _$_ReminderBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'reminders: ${reminders.toString()}';
    return '{$string}';
  }
}
