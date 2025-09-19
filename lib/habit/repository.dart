import 'dart:convert';
import 'package:localstorage/localstorage.dart';

import 'package:habitt/habit/model.dart';

/**
 * Abstract class/contract for implementing a Repository service
 * that manages the Habit domain model data.
 */
abstract class HabitsRepository {
  late List<Habit> habits;

  List<Habit> getHabits();

  void addHabit(Map<String, dynamic> data);

  void removeHabit(String label);

  void scheduleHabitNotification(
    Habit habit,
    NotificationType notification_type,
  );
}

/**
 * A localStorage implementation of HabitsRepository.
 * Only read and writes data from localStorage.
 */
final String STORAGE_KEY = 'habits';

class LocalStorageHabitsRepository implements HabitsRepository {
  late List<Habit> habits = [];
  LocalStorage storage;

  LocalStorageHabitsRepository({required this.storage}) {
    _loadHabitsFromStorage();
  }

  void _loadHabitsFromStorage() {
    print('LOAD HABITS FROM STORAGE');
    var storedHabits = storage.getItem(STORAGE_KEY);
    if (storedHabits != null) {
      var storedHabitsData = json.decode(storedHabits);
      this.habits = List<Habit>.from(
        (storedHabitsData as List).map((item) => Habit.fromJson(item)),
      );
    }
  }

  void _saveHabitsToStorage() {
    storage.setItem(
      STORAGE_KEY,
      jsonEncode(habits.map((e) => e.toJson()).toList()),
    );
  }

  List<Habit> getHabits() {
    return this.habits;
  }

  void addHabit(Map<String, dynamic> data) {
    print('Created Habit: ${Habit.fromJson(data)}');
    this.habits.add(Habit.fromJson(data));
    _saveHabitsToStorage();
  }

  void removeHabit(String label) {
    this.habits.removeWhere((h) => h.label == label);
    _saveHabitsToStorage();
  }

  // TODO   removing/updating/adding scheduled_notification for Habit
  void scheduleHabitNotification(
    Habit habit,
    NotificationType notification_type,
  ) {
    // TODO
    // habit.should_notify = true;
    habit.notification_type = notification_type;

    // Replace habit in habits with this modified version
  }
}
