import 'package:flutter/material.dart';

import 'package:habitt/user/repository.dart';

class UserViewModel with ChangeNotifier {
  UserRepository service;

  UserViewModel({required this.service});

  bool isLoggedIn() {
    return this.service.userIsLoggedIn();
  }

  void login(Map<String, dynamic> data) {
    this.service.login(data);
  }

  void register(Map<String, dynamic> data) {
    this.service.register(data);
  }

  void logout() {
    this.service.logout();
  }
}
