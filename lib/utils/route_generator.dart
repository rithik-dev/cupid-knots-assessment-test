import 'package:cupid_knot_assessment_test/screens/home_screen.dart';
import 'package:cupid_knot_assessment_test/screens/login_screen.dart';
import 'package:cupid_knot_assessment_test/screens/register_screen.dart';
import 'package:cupid_knot_assessment_test/screens/splash_screen.dart';
import 'package:cupid_knot_assessment_test/screens/update_profile_screen.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const _id = 'RouteGenerator';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments as dynamic;
    log(_id, msg: "Pushed ${settings.name}(${args ?? ''})");
    switch (settings.name) {
      case SplashScreen.id:
        return _route(const SplashScreen());
      case LoginScreen.id:
        return _route(LoginScreen());
      case RegisterScreen.id:
        return _route(RegisterScreen());
      case UpdateProfileScreen.id:
        return _route(UpdateProfileScreen());
      case HomeScreen.id:
        return _route(const HomeScreen());
      default:
        return _errorRoute(settings.name);
    }
  }

  static MaterialPageRoute _route(Widget widget) =>
      MaterialPageRoute(builder: (context) => widget);

  static Route<dynamic> _errorRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('ROUTE \n\n$name\n\nNOT FOUND'),
        ),
      ),
    );
  }
}
