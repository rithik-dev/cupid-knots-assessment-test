import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/models/user.dart';
import 'package:cupid_knot_assessment_test/screens/edit_profile_screen.dart';
import 'package:cupid_knot_assessment_test/screens/login_screen.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          padding: const EdgeInsets.only(bottom: 75),
          children: [
            _buildInfo(
              title: 'Full Name',
              propertyGetter: (user) => user.fullName,
            ),
            _buildInfo(
              title: 'Email',
              propertyGetter: (user) => user.email,
            ),
            _buildInfo(
              title: 'Mobile Number',
              propertyGetter: (user) => user.mobileNumber,
            ),
            _buildInfo(
              title: 'Gender',
              propertyGetter: (user) => user.gender,
            ),
            _buildInfo(
              title: 'Date of Birth',
              propertyGetter: (user) => user.dateOfBirth,
            ),
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                UserController.of(context, listen: false).logout();
                showSnackBar('Logged out successfully!');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  LoginScreen.id,
                  (route) => false,
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () => Navigator.pushNamed(context, EditProfileScreen.id),
        ),
      ),
    );
  }

  Widget _buildInfo({
    required String title,
    required String Function(User) propertyGetter,
  }) {
    return Consumer<UserController>(
      builder: (context, userCon, _) => ListTile(
        title: Text(title),
        subtitle: Text(userCon.isLoggedIn ? propertyGetter(userCon.user!) : ''),
      ),
    );
  }
}
