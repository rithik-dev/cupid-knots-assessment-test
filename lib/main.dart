import 'package:cupid_knot_assessment_test/controllers/contacts_controller.dart';
import 'package:cupid_knot_assessment_test/controllers/loading_controller.dart';
import 'package:cupid_knot_assessment_test/controllers/theme_controller.dart';
import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/screens/splash_screen.dart';
import 'package:cupid_knot_assessment_test/services/local_storage.dart';
import 'package:cupid_knot_assessment_test/utils/app_theme.dart';
import 'package:cupid_knot_assessment_test/utils/globals.dart';
import 'package:cupid_knot_assessment_test/utils/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:paginated_items_builder/paginated_items_builder.dart';
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
    Firebase.initializeApp(),
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
        ChangeNotifierProvider<ContactsController>(
          create: (_) => ContactsController(),
        ),
        ChangeNotifierProvider<ThemeController>(
          create: (_) => ThemeController(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        scrollBehavior: const _DefaultScrollBehavior(),
        builder: (context, child) {
          late final Color shimmerHighlightColor;

          switch (Theme.of(context).brightness) {
            case Brightness.light:
              shimmerHighlightColor = const Color(0xFFD4D7DD);
              break;
            case Brightness.dark:
              shimmerHighlightColor = const Color(0xFF5C2E62);
              break;
          }

          PaginatedItemsBuilder.config = PaginatedItemsBuilderConfig(
            shimmerConfig: ShimmerConfig(
              baseColor: Theme.of(context).cardColor,
              highlightColor: shimmerHighlightColor,
            ),
          );

          return child!;
        },
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
