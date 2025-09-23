import 'package:flutter_test/flutter_test.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:habitt/user/model.dart'; // adjust import to your actual path

void main() {
  group('User model', () {
    test('constructor assigns values correctly', () {
      final user = User(username: 'Alice', age: 25, country: 'Canada');

      expect(user.username, 'Alice');
      expect(user.age, 25);
      expect(user.country, 'Canada');
      expect(user.password, isEmpty); // default
    });

    test('password setter hashes input using SHA-256', () {
      final user = User(username: 'Bob', age: 30, country: 'USA');
      user.password = 'mySecret';

      final expectedHash = sha256.convert(utf8.encode('mySecret')).toString();

      expect(user.password, expectedHash);
      expect(user.password, isNot('mySecret')); // ensure not plain text
    });

    test('toJson serializes correctly with lowercase fields', () {
      final user = User(username: 'Charlie', age: 40, country: 'UK');
      user.password = 'password123';

      final json = user.toJson();

      expect(json['username'], 'charlie');
      expect(json['age'], 40);
      expect(json['password'], sha256.convert(utf8.encode('password123')).toString());
      expect(json['country'], 'uk');
    });

    test('fromJson deserializes and hashes password', () {
      final json = {
        'username': 'Dana',
        'age': 22,
        'password': 'superSecret',
        'country': 'Germany',
      };

      final user = User.fromJson(json);

      expect(user.username, 'Dana');
      expect(user.age, 22);
      expect(user.country, 'Germany');

      final expectedHash = sha256.convert(utf8.encode('superSecret')).toString();
      expect(user.password, expectedHash);
    });

    test('password remains consistent after multiple sets', () {
      final user = User(username: 'Eve', age: 28, country: 'France');

      user.password = 'abc123';
      final firstHash = user.password;

      user.password = 'abc123';
      final secondHash = user.password;

      expect(firstHash, secondHash); // same input → same hash
    });
  });
}
