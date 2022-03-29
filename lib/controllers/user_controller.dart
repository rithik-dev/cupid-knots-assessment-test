import 'package:cupid_knot_assessment_test/models/user.dart';
import 'package:cupid_knot_assessment_test/repositories/user_repository.dart';
import 'package:cupid_knot_assessment_test/utils/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserController extends ChangeNotifier {
  static UserController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<UserController>(context, listen: listen);

  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  Future<User?> _updateUser([User? newUser]) async {
    if (newUser == null) return null;
    _user = newUser;
    notifyListeners();
    return _user;
  }

  Future<User?> register(Map<String, dynamic> data) async {
    final _registeredUser = await UserRepository.registerUser(data);
    return await _updateUser(_registeredUser);
  }

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    final _loggedInUser = await UserRepository.loginUser(
      email: email,
      password: password,
    );
    return await _updateUser(_loggedInUser);
  }

  // Future<User?> initializeUser() async {
  //   if (Globals.accessToken == null) {
  //     return null;
  //   } else {
  //     final _currentUser = await UserRepository.getUserProfile();
  //     if (_currentUser == null) {
  //       Globals.accessToken = null;
  //       return null;
  //     } else {
  //       return await _updateUser(_currentUser);
  //     }
  //   }
  // }

  Future<void> logout() async {
    Globals.accessToken = null;
    clear();
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}
