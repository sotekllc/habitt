import 'package:flutter/material.dart';

import 'package:habitt/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(padding: AppSizes.screenPadding, child: Container()),
      ),
    );
  }
}
