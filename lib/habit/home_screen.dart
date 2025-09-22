import 'package:flutter/material.dart';
import 'package:habitt/habit/view_model.dart';
import 'package:provider/provider.dart';

import 'package:habitt/menu.dart';
import 'package:habitt/theme.dart';
import 'package:habitt/user/model.dart';
import 'package:habitt/user/view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var habitsViewModel = Provider.of<HabitsViewModel>(context);
    var userViewModel = Provider.of<UserViewModel>(context);

    var user = userViewModel.getUser();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColorDark,
        title: Text(
          user != null ? user.username : 'Habitt',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: AppSizes.screenPadding,
          child: Column(
            children: [
              Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 0,
                color: theme.dividerColor,
              ),

              Container(
                padding: AppSizes.sidePadding,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Text(
                        'ToDo',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.start,
                      ),
                      Icon(
                        Icons.pending,
                        color: theme.dividerColor,
                        size: 15.0,
                      ),
                    ],
                  ),
                ),
              ),

              ListView.builder(
                itemCount: habitsViewModel.filterTodoHabits().length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final habit = habitsViewModel.filterTodoHabits()[index];
                  return Dismissible(
                    key: Key(habit.label),
                    // onDoubleTap: () {
                    //   habitsViewModel.markHabitComplete(habit);
                    // },
                    onDismissed: (direction) {
                      habitsViewModel.markHabitComplete(habit);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Habit ${habit.label} completed.'),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        Container(
                          color: habit.color,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: habit.color,
                            ),
                            title: Text(habit.label, style: titleStyle),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              Divider(
                height: 20,
                thickness: 2,
                indent: 20,
                endIndent: 0,
                color: theme.dividerColor,
              ),

              Container(
                padding: AppSizes.sidePadding,
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Done',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.start,
                      ),
                      Icon(
                        Icons.check_box,
                        color: theme.dividerColor,
                        size: 15.0,
                      ),
                    ],
                  ),
                ),
              ),

              // TODO
              //  +filter for CompletedHabits ST completed_dt.day is today
              ListView.builder(
                itemCount: habitsViewModel.filterCompletedHabits().length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final habit = habitsViewModel.filterCompletedHabits()[index];
                  return Dismissible(
                    key: Key(habit.label),
                    onDismissed: (direction) {
                      habitsViewModel.markHabitIncomplete(habit);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Habit ${habit.label} in progress.'),
                        ),
                      );
                    },
                    // onDoubleTap: () {
                    //   habitsViewModel.markHabitIncomplete(habit);
                    // },
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          color: habit.color,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: habit.color,
                            ),
                            title: Text(habit.label, style: titleStyle),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      drawer: menuDrawer(context),
    );
  }
}
