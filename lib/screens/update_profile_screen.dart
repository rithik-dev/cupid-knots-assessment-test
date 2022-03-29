import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:cupid_knot_assessment_test/widgets/input_field.dart';
import 'package:cupid_knot_assessment_test/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatelessWidget {
  static const id = 'UpdateProfileScreen';

  UpdateProfileScreen({
    Key? key,
  }) : super(key: key);

  final _data = <String, dynamic>{};

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<UserController>(
        builder: (context, userCon, _) {
          return LoadingOverlay(
            screenId: UpdateProfileScreen.id,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Update Profile'),
              ),
              body: Form(
                key: _formKey,
                child: ListView(
                  cacheExtent: 500,
                  padding: const EdgeInsets.all(10).copyWith(bottom: 75),
                  children: [
                    InputField(
                      title: 'Full Name',
                      defaultValue: userCon.user?.fullName,
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
                      title: 'Mobile Number',
                      defaultValue: userCon.user?.mobileNumber,
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
                      title: 'Gender',
                      defaultValue: userCon.user?.gender,
                      onChanged: (v) => _data['gender'] = v,
                      validator: (v) {
                        if (isNullOrBlank(v)) {
                          return 'Gender cannot be empty!';
                        }
                        return null;
                      },
                    ),
                    InputField(
                      title: 'Date of Birth',
                      defaultValue: userCon.user?.dateOfBirth,
                      onChanged: (v) => _data['dob'] = v,
                      validator: (v) {
                        if (isNullOrBlank(v)) {
                          return 'Date of birth cannot be empty!';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.check),
                onPressed: () async {
                  if (_data.isEmpty) {
                    showSnackBar('Nothing updated');
                    return;
                  }

                  if (_formKey.currentState!.validate()) {
                    startLoading(context, UpdateProfileScreen.id);

                    _data['full_name'] ??= userCon.user?.fullName;
                    _data['mobile_no'] ??= userCon.user?.mobileNumber;
                    _data['gender'] ??= userCon.user?.gender;
                    _data['dob'] ??= userCon.user?.dateOfBirth;

                    final user = await UserController.of(
                      context,
                      listen: false,
                    ).updateProfile(_data);

                    stopLoading(context);

                    if (user != null) Navigator.pop(context);
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
