import 'package:cupid_knot_assessment_test/controllers/contacts_controller.dart';
import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/models/contact.dart';
import 'package:cupid_knot_assessment_test/screens/home_screen.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:cupid_knot_assessment_test/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  static const id = 'ContactCard';

  final Contact contact;

  const ContactCard(
    this.contact, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(contact.fullName),
      subtitle: Text('${contact.contactNumber} | ${contact.email}'),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          startLoading(context, HomeScreen.id);
          final success = await ContactsController.of(
            context,
            listen: false,
          ).deleteContact(
            userId: UserController.of(
              context,
              listen: false,
            ).user!.id.toString(),
            data: contact.toJson(),
          );
          stopLoading(context);
          showSnackBar(success
              ? 'Contact deleted successfully!'
              : 'Something went wrong!');
        },
      ),
    );
  }
}
