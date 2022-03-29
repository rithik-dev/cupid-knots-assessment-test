import 'package:cupid_knot_assessment_test/widgets/theme_list_tile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const id = 'ProfileScreen';

  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: const [
            ThemeListTile(),
          ],
        ),
      ),
    );
  }
}
