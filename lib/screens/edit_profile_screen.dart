import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  static const id = 'EditProfileScreen';

  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'EditProfileScreen',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
    );
  }
}
