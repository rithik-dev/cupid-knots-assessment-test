import 'package:cupid_knot_assessment_test/controllers/contacts_controller.dart';
import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:cupid_knot_assessment_test/widgets/input_field.dart';
import 'package:cupid_knot_assessment_test/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';

class AddContactScreen extends StatelessWidget {
  static const id = 'AddContactScreen';

  AddContactScreen({
    Key? key,
  }) : super(key: key);

  final _data = <String, dynamic>{};

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        screenId: AddContactScreen.id,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Contact'),
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(15).copyWith(bottom: 75),
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
                  title: 'Contact Number',
                  inputType: MyTextInputType.phone,
                  onChanged: (v) => _data['contact_number'] = v,
                  validator: (v) {
                    if (isNullOrBlank(v)) {
                      return 'Contact number cannot be empty!';
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
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            heroTag: AddContactScreen.id,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                startLoading(context, AddContactScreen.id);
                final success = await ContactsController.of(
                  context,
                  listen: false,
                ).createContact(
                  userId: UserController.of(
                    context,
                    listen: false,
                  ).user!.id.toString(),
                  data: _data,
                );
                stopLoading(context);

                if (success) Navigator.pop(context);
                showSnackBar(success
                    ? 'Contact added successfully!'
                    : 'Something went wrong!');
              }
            },
          ),
        ),
      ),
    );
  }
}
