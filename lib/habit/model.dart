import 'package:flutter/material.dart';

enum HabitStatus { TODO, COMPLETED, IN_PROGRESS }

class Habit {
  final String label;
  final HabitStatus status;
  final Color color;

  const Habit({required this.label, required this.status, required this.color});
}
