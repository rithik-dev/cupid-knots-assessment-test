import 'dart:convert';

import 'package:cupid_knot_assessment_test/models/user.dart';
import 'package:cupid_knot_assessment_test/repositories/user_repository.dart';
import 'package:cupid_knot_assessment_test/services/local_storage.dart';
import 'package:cupid_knot_assessment_test/utils/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserController extends ChangeNotifier {
  static UserController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<UserController>(context, listen: listen);

  static const _sharedPrefsKey = 'user';

  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  User? _updateUser(
    User? newUser, {
    bool updateLocalStorage = true,
  }) {
    if (newUser == null) return null;
    _user = newUser;

    // save to local storage
    if (updateLocalStorage) {
      LocalStorage.write(_sharedPrefsKey, jsonEncode(_user!.toJson()));
    }

    notifyListeners();
    return _user;
  }

  Future<User?> updateProfile(Map<String, dynamic> data) async {
    final _profile = await UserRepository.updateProfile(data);
    return _updateUser(_profile);
  }

  Future<User?> register(Map<String, dynamic> data) async {
    final _registeredUser = await UserRepository.registerUser(data);
    return _updateUser(_registeredUser);
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    final _loggedInUser = await UserRepository.loginUser(
      email: email,
      password: password,
    );
    return _updateUser(_loggedInUser);
  }

  Future<User?> initializeUser() async {
    // sample delay
    await Future.delayed(const Duration(milliseconds: 500));

    final userFromLocalStorage = LocalStorage.read(_sharedPrefsKey);
    if (userFromLocalStorage != null) {
      try {
        final user = User.fromJson(jsonDecode(userFromLocalStorage));
        Globals.accessToken = user.accessToken;
        return _updateUser(user, updateLocalStorage: false);
      } catch (_) {}
    }
    return null;
  }

  void logout() {
    Globals.accessToken = null;
    LocalStorage.remove(_sharedPrefsKey);
    clear();
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}
