import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  static const id = 'ContactsScreen';

  const ContactsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text(
            'ContactsScreen',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
    );
  }
}
