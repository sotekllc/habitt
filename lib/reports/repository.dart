import 'dart:convert';
import 'package:localstorage/localstorage.dart';

import 'package:habitt/habit/model.dart';
import 'package:habitt/reports/model.dart';

abstract class ReportsRepository {
  /**
   * Loads (all) stored completed Habits from
   * the storage medium.
   * 
   * TODO   performance improvement
   *  Could be improved by batch storing Habits
   * by the daterange/interval the reports will
   * be using to window the Habits.
   * (or implement caching if using remote store).
   */
  List<Habit> _loadHabits();

  /**
   * Remove a completed and stored Habit from the
   * reports collection in storage.
   */
  void removeCompletedHabit(Habit habit);

  /**
   * Add a Habit to the reports collection in 
   * storage.
   */
  void saveCompletedHabit(Habit habit);

  /**
   * Builds and returns a WeekylReport object that
   * contains a List of Habits completed in the
   * most recent week.
   */
  Future<WeeklyReport> getWeeklyHabitsReport();
}

final String STORAGE_KEY = 'completed_habits';

/**
 * Works by using LocalStorage to store all completed habits,
 * regardless of completed datetime. 
 * When pulling data for a report, filters these habits by
 * the completion_dt being within X days of today.
 * Responsible for the storage and retrieval of all completed 
 * Habits. Also has an endpoint for each report interval
 * (default just weekly).
 * 
 * Could be improved via either caching or storing the habits
 * in groups corresponding to report periods to reduce the
 * performance/I\O hit of processing all habits.
 */
class LocalStorageReportsRepository implements ReportsRepository {
  late WeeklyReport _weeklyReport;
  LocalStorage storage;

  WeeklyReport get weeklyReport => _weeklyReport;

  void set weeklyReport(WeeklyReport report) {
    this._weeklyReport = report;
  }

  LocalStorageReportsRepository({required this.storage});

  List<Habit> _loadHabits() {
    var storedHabits = storage.getItem(STORAGE_KEY);
    if (storedHabits != null) {
      var storedHabitsData = json.decode(storedHabits);
      return List<Habit>.from(
        (storedHabitsData as List).map((item) => Habit.fromJson(item)),
      );
    }
    return [];
  }

  void _saveHabits(List<Habit> habits) {
    storage.setItem(
      STORAGE_KEY,
      jsonEncode(habits.map((e) => e.toJson()).toList()),
    );
  }

  void removeCompletedHabit(Habit habit) {
    List<Habit> habits = this._loadHabits();
    habits.removeWhere((h) => h.id == habit.id);
    this._saveHabits(habits);
  }

  void saveCompletedHabit(Habit habit) {
    List<Habit> habits = this._loadHabits();
    habits.add(habit);
    this._saveHabits(habits);
  }

  Future<WeeklyReport> getWeeklyHabitsReport() async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    List<Habit> habits = this._loadHabits();
    List<Habit> filteredHabits = habits.where((habit) {
      final dt = habit.completion_dt;
      // Keep only those with a completion date in [sevenDaysAgo, now]
      return dt != null && dt.isAfter(sevenDaysAgo) && dt.isBefore(now);
    }).toList();

    return Future.delayed(Duration(seconds: 2), () {
      return WeeklyReport(
        startTime: now,
        endTime: sevenDaysAgo,
        completedHabits: filteredHabits,
      );
    });
  }
}
