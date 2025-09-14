import 'package:flutter/material.dart';

enum HabitStatus { TODO, COMPLETED, IN_PROGRESS }

enum NotificationType { MORNING, AFTERNOON, EVENING, NONE }

class Habit {
  final String label;
  final HabitStatus status;
  final Color color;
  bool _should_notify = false;
  NotificationType _notification_type = NotificationType.NONE;

  bool get should_notify => _should_notify;

  void set should_notify(bool value) {
    this._should_notify = value;
  }

  NotificationType get notification_type => _notification_type;

  void set notification_type(NotificationType type) {
    this._notification_type = type;
  }

  Habit({required this.label, required this.status, required this.color});
}
