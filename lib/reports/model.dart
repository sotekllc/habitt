import 'dart:convert';

import 'package:habitt/habit/model.dart';

class WeeklyReport {
  final DateTime startTime;
  final DateTime endTime;
  final List<Habit> completedHabits;

  WeeklyReport({
    required this.startTime,
    required this.endTime,
    required this.completedHabits,
  });

  /**
   * Serializing the list back to Json for storage.
   */
  List<Map<String, dynamic>> toJson() {
    return this.completedHabits.map((h) => h.toJson()).toList();
  }
}
