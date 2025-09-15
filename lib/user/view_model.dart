import 'package:flutter/material.dart';

import 'package:habitt/user/repository.dart';

class UserViewModel with ChangeNotifier {
  UserRepository service;

  UserViewModel({required this.service});

  bool isLoggedIn() {
    return this.service.userIsLoggedIn();
  }

  void login() {}

  void register() {}

  void logout() {}
}
