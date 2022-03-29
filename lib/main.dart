import 'package:cupid_knot_assessment_test/controllers/loading_controller.dart';
import 'package:cupid_knot_assessment_test/controllers/theme_controller.dart';
import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/screens/splash_screen.dart';
import 'package:cupid_knot_assessment_test/services/local_storage.dart';
import 'package:cupid_knot_assessment_test/utils/app_theme.dart';
import 'package:cupid_knot_assessment_test/utils/globals.dart';
import 'package:cupid_knot_assessment_test/utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // initialize main
  await Future.wait(<Future>[
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    LocalStorage.initialize(),
  ]);

  // end
  FlutterNativeSplash.remove();
  runApp(const _MainApp());
}

class _MainApp extends StatelessWidget {
  const _MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingController>(
          create: (_) => LoadingController(),
        ),
        ChangeNotifierProvider<UserController>(
          create: (_) => UserController(),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const _DefaultScrollBehavior(),
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeController.of(context).themeMode,
        navigatorKey: Globals.navigatorKey,
        scaffoldMessengerKey: Globals.scaffoldMessengerKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: SplashScreen.id,
      ),
    );
  }
}

class _DefaultScrollBehavior extends ScrollBehavior {
  const _DefaultScrollBehavior({
    AndroidOverscrollIndicator? androidOverscrollIndicator,
  }) : super(androidOverscrollIndicator: androidOverscrollIndicator);

  @override
  Widget buildViewportChrome(_, child, __) => child;
}
