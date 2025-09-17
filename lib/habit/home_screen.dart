import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:habitt/menu.dart';
import 'package:habitt/theme.dart';
import 'package:habitt/user/model.dart';
import 'package:habitt/user/view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var userViewModel = Provider.of<UserViewModel>(context);
    User? user = userViewModel.getUser();
    user?.username;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColorDark,
        title: const Text(
          'Habitt',
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
          child: Column(children: [
            const Text(
            'HOME SCREEN',
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user != null ? user.username : "User Unknown",
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          ],)
        ),
      ),
      drawer: menuDrawer(context),
    );
  }
}
