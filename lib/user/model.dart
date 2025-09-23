import 'dart:convert';
import 'package:crypto/crypto.dart';

class User {
  final String username;
  final int age;
  String _password = '';
  final String country;

  String get password => _password;

  // OPTIONS
  //  store isLoggedIn in local storage to bypass Login/Register if logged in until logged out.
  //    OR local storage user data and *assume* valid if data is stored w/ no auth checking.
  //  use sqlite to store user data and check if username/pass persisted and matches entries;
  //    logout clears local storage of user data but not sqlite data. Login stores user data in
  //    local storage.
  //
  //  Implement both starting from an abstract UserRepository class.
  //  Start prototype with only local storage\in-memory persistence.

  /**
   * Encrpt the password as a form of hashing so we're not 
   * storing or using the plaintext user password.
   */
  void set password(String text) {
    final bytes = utf8.encode(text);
    final hash = sha256.convert(bytes);
    this._password = hash.toString();
  }

  User({required this.username, required this.age, required this.country});

  factory User.fromJson(Map<String, dynamic> data) {
    User _user = User(
      username: data['username'],
      age: data['age'],
      country: data['country'],
    );
    _user.password = data['password'];

    return _user;
  }

  Map<String, dynamic> toJson() {
    return {
      'username': this.username.toLowerCase(),
      'age': this.age,
      'password': this.password,
      'country': this.country.toLowerCase(),
    };
  }
}
