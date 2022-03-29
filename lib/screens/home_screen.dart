import 'package:cupid_knot_assessment_test/widgets/theme_list_tile.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'HomeScreen';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap the back button again to exit the app!'),
          ),
          child: ListView(
            children: const [
              ThemeListTile(),
            ],
          ),
        ),
      ),
    );
  }
}
