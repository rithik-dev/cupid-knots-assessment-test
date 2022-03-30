import 'package:cupid_knot_assessment_test/controllers/contacts_controller.dart';
import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/models/contact.dart';
import 'package:cupid_knot_assessment_test/screens/contacts_screen.dart';
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
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.fullName,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 15),
                  Text('Email: ${contact.email}'),
                  const SizedBox(height: 5),
                  Text('Contact Number: ${contact.contactNumber}'),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              startLoading(context, ContactsScreen.id);
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
        ],
      ),
    );
  }
}
