import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:habitt/menu.dart';
import 'package:habitt/reports/model.dart';
import 'package:habitt/reports/view_model.dart';
import 'package:habitt/theme.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  List<DateTime> getLast7Days() {
    final now = DateTime.now();
    return List.generate(
      7,
      (index) => DateTime(now.year, now.month, now.day - index),
    );
  }

  @override
  Widget build(BuildContext context) {
    var reportsViewModel = Provider.of<ReportsViewModel>(context);
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColorDark,
        title: const Text(
          'Weekly Report',
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder(
        future: reportsViewModel.getWeeklyHabitsReport(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else if (snapshot.data!.completedHabits.isEmpty) {
                return const Center(
                  child: Text(
                    'No data available. Please configure habits first.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: _buildColumns(snapshot.data),
                      rows: _buildRows(snapshot.data),
                    ),
                  ),
                );
              }
            default:
              return Text(
                'Unhandle State, problem loading WeeklyReport data!',
                style: TextStyle(color: Colors.red),
              );
          }
        },
      ),
      drawer: menuDrawer(context),
    );
  }

  List<DataColumn> _buildColumns(WeeklyReport? reportData) {
    List<DateTime> daysOfWeek = getLast7Days();

    return [
      const DataColumn(
        label: Text('Habit', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      ...daysOfWeek.map(
        (dt) => DataColumn(
          label: Text(
            DateFormat('EEE').format(dt),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ];
  }

  List<DataRow> _buildRows(WeeklyReport? reportData) {
    List<DateTime> daysOfWeek = getLast7Days();

    return reportData!.completedHabits.toList().map((habit) {
      return DataRow(
        cells: [
          DataCell(Text(habit.label)),
          ...daysOfWeek.map((dt) {
            bool isCompleted =
                dt.year == habit.completion_dt?.year &&
                dt.month == habit.completion_dt?.month &&
                dt.day == habit.completion_dt?.day;
            return DataCell(
              Icon(
                isCompleted ? Icons.check_circle : Icons.cancel,
                color: isCompleted ? Colors.green : Colors.red,
              ),
            );
          }),
        ],
      );
    }).toList();
  }
}
