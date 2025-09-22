import 'package:flutter/material.dart';

import 'package:habitt/habit/model.dart';
import 'package:habitt/reports/model.dart';
import 'package:habitt/reports/repository.dart';

class ReportsViewModel with ChangeNotifier {
  final ReportsRepository service;

  ReportsViewModel({required this.service});

  void removeCompletedHabit(Habit habit) {
    this.service.removeCompletedHabit(habit);
    notifyListeners();
  }

  void saveCompletedHabit(Habit habit) {
    this.service.saveCompletedHabit(habit);
    notifyListeners();
  }

  Future<WeeklyReport> getWeeklyHabitsReport() {
    return Future.delayed(Duration(seconds: 2), () {
      return this.service.getWeeklyHabitsReport();
    });
  }
}
