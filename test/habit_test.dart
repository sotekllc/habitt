import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:habitt/habit/model.dart';

void main() {
  group('Habit model', () {
    test('constructor assigns values correctly', () {
      final habit = Habit(
        id: '1',
        label: 'Workout',
        status: HabitStatus.IN_PROGRESS,
        color: Colors.green,
      );

      expect(habit.id, '1');
      expect(habit.label, 'Workout');
      expect(habit.status, HabitStatus.IN_PROGRESS);
      expect(habit.color.value, Colors.green.value);
      expect(habit.notification_type, NotificationType.NONE);
      expect(habit.completion_dt, isNull);
    });

    test('toJson serializes correctly', () {
      final habit = Habit(
        id: '1',
        label: 'Read',
        status: HabitStatus.COMPLETED,
        color: Colors.red,
      );
      habit.notification_type = NotificationType.EVENING;
      habit.completion_dt = DateTime(2025, 01, 19, 12, 0);

      final json = habit.toJson();

      expect(json['id'], '1');
      expect(json['label'], 'read'); // lowercased in toJson
      expect(json['status'], 'COMPLETED');
      expect(json['color'], Colors.red.value);
      expect(json['notification_type'], 'EVENING');
      expect(json['completion_dt'], '2025-01-19T12:00:00.000');
    });

    test('fromJson deserializes correctly', () {
      final json = {
        'id': '42',
        'label': 'Meditate',
        'status': 'TODO',
        'color': Colors.blue.value,
        'notification_type': 'MORNING',
        'completion_dt': '2025-01-18T08:30:00.000',
      };

      final habit = Habit.fromJson(json);

      expect(habit.id, '42');
      expect(habit.label, 'Meditate');
      expect(habit.status, HabitStatus.TODO);
      expect(habit.color.value, Colors.blue.value);
      expect(habit.notification_type, NotificationType.MORNING);
      expect(habit.completion_dt, DateTime(2025, 1, 18, 8, 30));
    });

    test('fromJson assigns UUID if id is missing', () {
      final json = {
        'label': 'Drink Water',
        'status': 'COMPLETED',
        'color': Colors.orange.value,
      };

      final habit = Habit.fromJson(json);

      expect(habit.id, isNotEmpty); // generated UUID
      expect(habit.label, 'Drink Water');
      expect(habit.status, HabitStatus.COMPLETED);
      expect(habit.color.value, Colors.orange.value);
      expect(habit.notification_type, NotificationType.NONE);
      expect(habit.completion_dt, isNull);
    });

    test('completion_dt getter/setter works', () {
      final habit = Habit(
        id: '99',
        label: 'Stretch',
        status: HabitStatus.TODO,
        color: Colors.purple,
      );

      expect(habit.completion_dt, isNull);

      final now = DateTime.now();
      habit.completion_dt = now;

      expect(habit.completion_dt, now);
    });
  });
}
