import 'package:flutter/material.dart';

import 'package:habitt/user/model.dart';
import 'package:habitt/user/repository.dart';

class UserViewModel with ChangeNotifier {
  UserRepository service;

  UserViewModel({required this.service});

  bool isLoggedIn() {
    return this.service.userIsLoggedIn();
  }

  User? getUser() {
    return this.service.getUser();
  }

  void updateUserDetails(Map<String, dynamic> data) {
    this.service.updateUserDetails(data);
    notifyListeners();
  }

  void login(Map<String, dynamic> data) {
    this.service.login(data);
    notifyListeners();
  }

  void register(Map<String, dynamic> data) {
    this.service.register(data);
    notifyListeners();
  }

  void logout() {
    this.service.logout();
    notifyListeners();
  }
}
