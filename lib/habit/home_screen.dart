import 'package:flutter/material.dart';

import 'package:habitt/menu.dart';
import 'package:habitt/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

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
          child: const Text(
            'HOME SCREEN',
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
