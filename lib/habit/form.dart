import 'package:flutter/material.dart';

import 'package:habitt/menu.dart';
import 'package:habitt/theme.dart';

class HabitsFormScreen extends StatefulWidget {
  const HabitsFormScreen({Key? key}) : super(key: key);

  @override
  _HabitsFormScreenState createState() => _HabitsFormScreenState();
}

class _HabitsFormScreenState extends State<HabitsFormScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColorDark,
        title: const Text(
          'Habits',
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
          child: const Text(
            'HABITS FORM SCREEN',
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: menuDrawer(context),
    );
  }
}
