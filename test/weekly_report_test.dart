import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:habitt/habit/model.dart';
import 'package:habitt/reports/model.dart';

void main() {
  group('WeeklyReport', () {
    test('constructor assigns values correctly', () {
      final start = DateTime(2025, 1, 1);
      final end = DateTime(2025, 1, 7);

      final habit = Habit(
        id: '1',
        label: 'Workout',
        status: HabitStatus.COMPLETED,
        color: Colors.blue,
      );

      final report = WeeklyReport(
        startTime: start,
        endTime: end,
        completedHabits: [habit],
      );

      expect(report.startTime, start);
      expect(report.endTime, end);
      expect(report.completedHabits.length, 1);
      expect(report.completedHabits.first.label, 'Workout');
    });

    test('toJson serializes completedHabits correctly', () {
      final habit1 = Habit(
        id: '1',
        label: 'Workout',
        status: HabitStatus.COMPLETED,
        color: Colors.blue,
      );

      final habit2 = Habit(
        id: '2',
        label: 'Read',
        status: HabitStatus.COMPLETED,
        color: Colors.red,
      );

      final report = WeeklyReport(
        startTime: DateTime(2025, 1, 1),
        endTime: DateTime(2025, 1, 7),
        completedHabits: [habit1, habit2],
      );

      final json = report.toJson();

      expect(json, isA<List<Map<String, dynamic>>>());
      expect(json.length, 2);

      expect(json[0]['label'], 'workout'); // toJson lowercased in Habit
      expect(json[0]['status'], 'COMPLETED');
      expect(json[0]['color'], Colors.blue.value);

      expect(json[1]['label'], 'read');
      expect(json[1]['status'], 'COMPLETED');
      expect(json[1]['color'], Colors.red.value);
    });
  });
}
