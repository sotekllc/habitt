import 'dart:convert';
import 'dart:math';
import 'package:localstorage/localstorage.dart';

import 'package:habitt/user/country_service.dart';
import 'package:habitt/user/model.dart';

/**
 * Base repository class for User data.
 * Intended to be a service dependency for a UserViewModel.
 */
abstract class UserRepository {
  late User _user;

  /**
   * Uses the configured storage to determine if there is saved user data
   * and, depending on the implementation, if the saved user data also
   * matches database stored user data.
   */
  bool userIsLoggedIn();

  /**
   * Returns the current User object (which is defined IFF
   * the User is logged in).
   */
  User getUser();

  /**
   * Performs user authentication using a username/password.
   * Sets the User object for the service if successful,
   * throws an exception otherwise.
   */
  void login(Map<String, dynamic> data);

  /**
   * Creates a new User via registration and stores the new user
   * data for subsequent authorization checks.
   * Throws an exception if this process errors out.
   */
  void register(Map<String, dynamic> data);

  /**
   * Logs a User out and clears memory/localstorage of any 
   * saved/cached user data.
   * Does not alter database stored user data as sessions
   * are only stored in-memory/localstorage and never
   * cached remotely.
   */
  void logout();
}

/**
 * In-memory\local storage implementation of UserRepository.
 * Uses local storage to store data in between app sessions.
 */
final String STORAGE_KEY = 'user';

class InMemoryUserRepository implements UserRepository {
  late User _user;
  final LocalStorage storage;
  final CountryService countryService;

  // User get user => _user;

  // void set user(User user) {
  //   this._user = user;
  // }

  InMemoryUserRepository({required this.storage, required this.countryService}) {
    _loadUserFromStorage();
  }

  // TODO
  //  Switch to storing user in flutter_secure_storage
  void _loadUserFromStorage() {
    var storedUser = storage.getItem(STORAGE_KEY);
    if (storedUser != null) {
      this._user = User.fromJson(jsonDecode(storedUser));
    }
  }

  /**
   * For localstorage\in-memory user data storage
   */
  bool userIsLoggedIn() {
    return this._user.username.isNotEmpty;
  }

  User getUser() {
    return this._user;
  }

  /**
   * PASS-THRU
   * Simplifying initial development with an in-memory only storage 
   * UserRepository. This means we cannot distinguish registration with
   * login because we have no source of truth besides localstorage to
   * compare to.
   * Thus for this simplified service we only store user data AS-IF
   * it's a valid user. We check localstorage for any user data to
   * determine if there's a saved login session.
   */
  void login(Map<String, dynamic> data) {
    // No source of truth to validate credentials; we assume valid form
    //  data is valid User data and set the User object and store the
    //  data locally.
    var randCountryIndex = Random().nextInt(
      this.countryService.getCountries().length,
    );

    this._user = User(
      username: data['username'],
      age: Random().nextInt(100) + 18,
      country: this.countryService.getCountries()[randCountryIndex],
    );
  }

  /**
   * PASS-THRU
   * Simplifying initial development with an in-memory only storage 
   * UserRepository. This means we cannot distinguish registration with
   * login because we have no source of truth besides localstorage to
   * compare to.
   */
  void register(Map<String, dynamic> data) {
    this._user = User(
      username: data['username'],
      age: data['age'],
      country: data['country']
    );
    this._user.password = data['password'];
    // this.login(data);
  }

  void logout() {}
}

/**
 * Local SQLite database storage implementation of UserRepository.
 * Uses a local SQLite instance to store user data and
 * local storage for "caching" of user data.
 */
// class DatabaseUserRepository implements UserRepository {
//   bool userIsLoggedIn() {}

//   void login() {}

//   void register() {}

//   void logout() {}
// }
