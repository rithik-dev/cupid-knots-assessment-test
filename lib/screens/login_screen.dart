import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/screens/home_screen.dart';
import 'package:cupid_knot_assessment_test/screens/register_screen.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:cupid_knot_assessment_test/widgets/input_field.dart';
import 'package:cupid_knot_assessment_test/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const id = 'LoginScreen';

  LoginScreen({
    Key? key,
  }) : super(key: key);

  final _data = <String, dynamic>{};

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        screenId: LoginScreen.id,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(15).copyWith(top: 25),
              children: [
                InputField(
                  title: 'Email',
                  autofocus: true,
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
                  title: 'Password',
                  onChanged: (v) => _data['password'] = v,
                  inputType: MyTextInputType.none,
                  validator: (v) {
                    if (isNullOrBlank(v)) {
                      return 'Password cannot be empty!';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    RegisterScreen.id,
                  ),
                  child: const Text("Don't have an account? Register!"),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.check),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                startLoading(context, LoginScreen.id);

                final user = await UserController.of(
                  context,
                  listen: false,
                ).login(
                  email: _data['email'],
                  password: _data['password'],
                );

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
