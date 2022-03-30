import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/screens/home_screen.dart';
import 'package:cupid_knot_assessment_test/screens/login_screen.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:cupid_knot_assessment_test/widgets/date_of_birth_getter.dart';
import 'package:cupid_knot_assessment_test/widgets/input_field.dart';
import 'package:cupid_knot_assessment_test/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  static const id = 'RegisterScreen';

  RegisterScreen({
    Key? key,
  }) : super(key: key);

  final _data = <String, dynamic>{};

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        screenId: RegisterScreen.id,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Register'),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              cacheExtent: 1000,
              padding: const EdgeInsets.all(15).copyWith(top: 25, bottom: 75),
              children: [
                InputField(
                  title: 'Full Name',
                  autofocus: true,
                  inputType: MyTextInputType.sentences,
                  onChanged: (v) => _data['full_name'] = v,
                  validator: (v) {
                    if (isNullOrBlank(v)) {
                      return 'Full name cannot be empty!';
                    }
                    return null;
                  },
                ),
                InputField(
                  title: 'Email',
                  inputType: MyTextInputType.email,
                  onChanged: (v) => _data['email'] = v,
                  validator: (v) {
                    if (isNullOrBlank(v) || !v!.contains('@')) {
                      return 'Please enter a valid email address!';
                    }
                    return null;
                  },
                ),
                InputField(
                  title: 'Mobile Number',
                  inputType: MyTextInputType.phone,
                  onChanged: (v) => _data['mobile_no'] = v,
                  validator: (v) {
                    if (isNullOrBlank(v)) {
                      return 'Mobile number cannot be empty!';
                    }
                    return null;
                  },
                ),
                InputField(
                  title: 'Password',
                  inputType: MyTextInputType.none,
                  onChanged: (v) => _data['password'] = v,
                  validator: (v) {
                    if (isNullOrBlank(v)) {
                      return 'Password cannot be empty!';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                InputField(
                  title: 'Confirm Password',
                  inputType: MyTextInputType.none,
                  onChanged: (v) => _data['c_password'] = v,
                  validator: (v) {
                    if (isNullOrBlank(v)) {
                      return 'Confirmation password cannot be empty!';
                    } else if (v != _data['password']) {
                      return 'Passwords are not equal!';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                InputField(
                  title: 'Gender',
                  onChanged: (v) => _data['gender'] = v,
                  validator: (v) {
                    if (isNullOrBlank(v)) {
                      return 'Gender cannot be empty!';
                    }
                    return null;
                  },
                ),
                DateOfBirthGetter(onUpdate: (v) => _data['dob'] = v),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    LoginScreen.id,
                  ),
                  child: const Text('Already have an account? Login!'),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                startLoading(context, RegisterScreen.id);

                final user = await UserController.of(
                  context,
                  listen: false,
                ).register(_data);

                stopLoading(context);

                if (user != null) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    HomeScreen.id,
                    (route) => false,
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
