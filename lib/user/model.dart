import 'dart:convert';
import 'package:crypto/crypto.dart';


class User {
  final String email;
  final int age;
  String _password = '';
  final String country;

  String get password => _password;

  /**
   * Encrpt the password as a form of hashing so we're not 
   * storing or using the plaintext user password.
   */
  void set password(String text) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    this._password = hash.toString();
  }
  
  User({required this.email, required this.age, required this.country});
}