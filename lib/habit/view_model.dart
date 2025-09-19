import 'package:flutter/material.dart';

import 'package:habitt/habit/model.dart';
import 'package:habitt/habit/repository.dart';

class HabitsViewModel with ChangeNotifier {
  HabitsRepository service;

  HabitsViewModel({required this.service});

  List<Habit> getHabits() {
    return this.service.habits;
  }

  void addHabit(Map<String, dynamic> data) {
    print('Add Habit: ${data}');
    this.service.addHabit(data);
    notifyListeners();
  }

  void removeHabit(String label) {
    this.service.removeHabit(label);
    notifyListeners();
  }

  void markHabitComplete(Habit habit) {
    this.service.updateHabitStatus(habit, HabitStatus.COMPLETED);
    notifyListeners();
  }

  void markHabitIncomplete(Habit habit) {
    this.service.updateHabitStatus(habit, HabitStatus.TODO);
    notifyListeners();
  }
  
  List<Habit> filterTodoHabits() {
    return this.service.habits
        .where((habit) => habit.completion_dt == null)
        .toList();
  }

  List<Habit> filterCompletedHabits() {
    return this.service.habits
        .where((habit) => habit.completion_dt != null)
        .toList();
  }

  void scheduleHabitNotification(
    Habit habit,
    NotificationType notification_type,
  ) {
    // TODO
    //  (?) if clicked again and called, have method check if scheduling exists already,
    //  if so remove scheduling, if not already present add scheduling ?
  }
}
