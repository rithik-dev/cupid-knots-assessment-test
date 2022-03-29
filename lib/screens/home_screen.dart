import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/screens/contacts_screen.dart';
import 'package:cupid_knot_assessment_test/screens/login_screen.dart';
import 'package:cupid_knot_assessment_test/screens/profile_screen.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:cupid_knot_assessment_test/widgets/loading_overlay.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _bottomNavItems = [
    BottomNavigationBarItem(
      label: 'Profile',
      icon: Icon(Icons.person),
    ),
    BottomNavigationBarItem(
      label: 'Contacts',
      icon: Icon(Icons.contacts),
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        screenId: HomeScreen.id,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_bottomNavItems[_selectedIndex].label!),
            actions: [
              InkWell(
                onTap: () async {
                  startLoading(context, HomeScreen.id);
                  await UserController.of(context, listen: false).logout();
                  stopLoading(context);
                  showSnackBar('Logged out successfully');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LoginScreen.id,
                    (route) => false,
                  );
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Logout',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyText2?.copyWith(fontSize: 17),
                    ),
                  ),
                ),
              )
            ],
          ),
          body: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap the back button again to exit the app!'),
            ),
            child: IndexedStack(
              index: _selectedIndex,
              children: const [
                ProfileScreen(),
                ContactsScreen(),
              ],
            ),
          ),
          bottomNavigationBar: SizedBox(
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: (index) => setState(() => _selectedIndex = index),
              items: _bottomNavItems,
            ),
          ),
        ),
      ),
    );
  }
}
