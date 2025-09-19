import 'package:flutter/material.dart';
import 'package:habitt/habit/home_screen.dart';
import 'package:habitt/user/login_screen.dart';
import 'package:provider/provider.dart';

import 'package:habitt/habit/form.dart';
import 'package:habitt/notifications/screen.dart';
import 'package:habitt/reports/screen.dart';
import 'package:habitt/settings/screen.dart';
import 'package:habitt/user/view_model.dart';

Widget menuDrawer(BuildContext context) {
  var theme = Theme.of(context);
  var userProvider = Provider.of<UserViewModel>(context);

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: theme.primaryColorDark),
          child: Text(
            'Menu',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          title: const Text('Home'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
        ListTile(
          title: const Text('Habits'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HabitsFormScreen()),
            );
          },
        ),
        ListTile(
          title: const Text('Reports'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ReportsScreen()),
            );
          },
        ),
        ListTile(
          title: const Text('Notifications'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NotificationsScreen()),
            );
          },
        ),
        ListTile(
          title: const Text('Settings'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        ListTile(
          title: const Text('Sign out'),
          onTap: () {
            userProvider.logout();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ],
    ),
  );
}
