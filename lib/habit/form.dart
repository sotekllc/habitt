import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:habitt/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:habitt/habit/view_model.dart';
import 'package:habitt/menu.dart';
import 'package:habitt/theme.dart';
import 'package:habitt/widgets.dart';

class HabitsFormScreen extends StatefulWidget {
  const HabitsFormScreen({Key? key}) : super(key: key);

  @override
  _HabitsFormScreenState createState() => _HabitsFormScreenState();
}

class _HabitsFormScreenState extends State<HabitsFormScreen> {
  late FToast fToast;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  late String selectedColorName;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    selectedColorName = habitColors.keys.first;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _addHabit(String label, String color_name) {
    var habitsViewModel = Provider.of<HabitsViewModel>(context, listen: false);

    try {
      habitsViewModel.addHabit({
        'label': label,
        'color': habitColors[color_name],
      });

      showToast(fToast, 'User registered, logging in...', Colors.greenAccent);
    } catch (e) {
      print('Error creating new habit: $e');
      showToast(fToast, e.toString(), Colors.redAccent);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var habitsViewModel = Provider.of<HabitsViewModel>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

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
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: AppSizes.screenPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildInputField(
                  _usernameController,
                  'Username',
                  Icons.alternate_email,
                  theme,
                ),

                const SizedBox(height: 20),
                _buildColorsDropdown(theme),
                const SizedBox(height: 20),

                OutlinedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addHabit(_usernameController.text, selectedColorName);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: theme.splashColor,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 70,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Add Habit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),

                const SizedBox(height: 20),

                ListView.builder(
                  itemCount: habitsViewModel.getHabits().length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final habit = habitsViewModel.getHabits()[index];
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundColor: habit.color,
                      ),
                      title: themeProvider.mode == UI_THEME.DARK
                          ? Text(habit.label, style: TextStyle(color: Colors.white),)
                          : Text(habit.label, style: TextStyle(color: Colors.black),),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          habitsViewModel.removeHabit(habit.label);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: menuDrawer(context),
    );
  }

  Widget _buildColorsDropdown(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: formFieldDecoration,
      child: InputDecorator(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        child: DropdownButton<String>(
          value: selectedColorName,
          icon: Icon(Icons.arrow_drop_down, color: theme.primaryColorDark),
          isExpanded: true,
          underline: const SizedBox(),
          items: habitColors.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Container(
                color: entry.value,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(entry.key, style: TextStyle(color: Colors.black)),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedColorName = newValue!;
            });
          },
        ),
      ),
    );
  }
}
