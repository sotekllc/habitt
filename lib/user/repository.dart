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
  late User? _user;

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
  User? getUser();

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

class LocalStorageUserRepository implements UserRepository {
  late User? _user = null;
  final LocalStorage storage;
  final CountryService countryService;

  LocalStorageUserRepository({
    required this.storage,
    required this.countryService,
  }) {
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

  void _storeUserInStorage() {
    storage.setItem(STORAGE_KEY, jsonEncode(this._user?.toJson()));
  }

  /**
   * For localstorage\in-memory user data storage
   */
  bool userIsLoggedIn() {
    // return this._user.username.isNotEmpty;
    return this._user != null;
  }

  /**
   * Returns either the stored User object or null.
   */
  User? getUser() {
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

    // With no backend storage and no DB for the LocalStorage implementation,
    //  we have no comparisons to make to login, so we treat any data
    //  as valid and randomize a User object.
    // Other implementations of UserRepository will use a database as
    //  the source of truth for authentication (instead of pass-thru).
    // We could have stored User on registration and compared credentials to
    //  LocalStorage users, but then we'd have to manage storing multiple users
    //  in LocalStorage which is unnecessary. (We just need a dummy service for v0).
    this._user = User(
      username: data['username'],
      age: Random().nextInt(100) + 18,
      country: this.countryService.getCountries()[randCountryIndex],
    );
    this._user?.password = data['password'];

    _storeUserInStorage();
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
      country: data['country'],
    );
    this._user?.password = data['password'];

    _storeUserInStorage();
  }

  /**
   * PASS-THRU
   * Pass-thru logout method for in-memory only implementation of
   * UserRepository.
   * No backend or db source of truth means we just need to wipe
   * the local user data including what's in localStorage.
   */
  void logout() {
    this._user = null;
    storage.removeItem(STORAGE_KEY);
  }
}

class AlwaysFailingUserRepository implements UserRepository {
  late User? _user = null;
  final LocalStorage storage;
  final CountryService countryService;

  AlwaysFailingUserRepository({
    required this.storage,
    required this.countryService,
  }) {
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

  void _storeUserInStorage() {
    throw UnimplementedError('Failed to save User data.');
  }

  /**
   * For localstorage\in-memory user data storage
   */
  bool userIsLoggedIn() {
    // return this._user.username.isNotEmpty;
    return this._user != null;
  }

  /**
   * Returns either the stored User object or null.
   */
  User? getUser() {
    return this._user;
  }

  void login(Map<String, dynamic> data) {
    throw UnimplementedError('Login failed');
  }

  void register(Map<String, dynamic> data) {
    throw UnimplementedError('Registration failed');
  }

  void logout() {
    this._user = null;
    storage.removeItem(STORAGE_KEY);
  }
}

// TODO SQLite? PostgreSQL? Fire store (documents)?
/**
 * Local SQLite database storage implementation of UserRepository.
 * Uses a local SQLite instance to store user data and
 * local storage for "caching" of user data.
 */
// class DatabaseUserRepository implements UserRepository {

//  void _loadUser()
//  void _saveUser()

//  User? getUser()

//   bool userIsLoggedIn() {}

//   void login() {}

//   void register() {}

//   void logout() {}
// }
