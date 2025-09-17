import 'package:flutter/material.dart';

enum HabitStatus { TODO, COMPLETED, IN_PROGRESS }

enum NotificationType { MORNING, AFTERNOON, EVENING, NONE }

class Habit {
  final String label;
  final HabitStatus status;
  final Color color;
  bool _should_notify = false;
  NotificationType _notification_type = NotificationType.NONE;
  DateTime? _completion_dt = null;

  bool get should_notify => _should_notify;

  void set should_notify(bool value) {
    this._should_notify = value;
  }

  NotificationType get notification_type => _notification_type;

  void set notification_type(NotificationType type) {
    this._notification_type = type;
  }

  DateTime? get completion_dt => _completion_dt;

  void set completion_dt(DateTime? completed) {
    this._completion_dt = completed;
  }

  Habit({required this.label, required this.status, required this.color});

  factory Habit.fromJson(Map<String, dynamic> data) {
    Habit habit = Habit(
      label: data['label'],
      status: data['status']
          ? HabitStatus.values.byName(data['status'])
          : HabitStatus.TODO,
      color: Color(data['color']),
    );
    habit.should_notify = data['should_notify'] != null
        ? data['should_notify'].toString().toLowerCase() == 'true'
        : false;
    habit.notification_type = data['notification_type'] != null
        ? NotificationType.values.byName(data['notification_type'])
        : NotificationType.NONE;
    habit.completion_dt = data['completion_dt'] != null
        ? DateTime.parse(data['completion_dt'])
        : null;

    return habit;
  }

  Map<String, dynamic> toJson() {
    return {
      'label': this.label.toLowerCase(),
      'status': this.status.toString(),
      'color': this.color.toString(),
      'should_notify': this._should_notify,
      'notification_type': this._notification_type,
      'completion_dt': this._completion_dt?.toIso8601String(),
    };
  }
}
