import 'package:cupid_knot_assessment_test/controllers/contacts_controller.dart';
import 'package:cupid_knot_assessment_test/controllers/user_controller.dart';
import 'package:cupid_knot_assessment_test/models/contact.dart';
import 'package:cupid_knot_assessment_test/screens/add_contact_screen.dart';
import 'package:cupid_knot_assessment_test/widgets/contact_card.dart';
import 'package:cupid_knot_assessment_test/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:paginated_items_builder/paginated_items_builder.dart';
import 'package:provider/provider.dart';

class ContactsScreen extends StatelessWidget {
  static const id = 'ContactsScreen';

  const ContactsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingOverlay(
        screenId: ContactsScreen.id,
        child: Scaffold(
          body: Consumer<ContactsController>(
            builder: (context, contactsCon, _) {
              return PaginatedItemsBuilder<Contact>(
                emptyText: 'No contacts found!',
                fetchPageData: (reset) => contactsCon.updateContacts(
                  userId: UserController.of(
                    context,
                    listen: false,
                  ).user!.id.toString(),
                  reset: reset,
                  showLoaderOnReset: reset,
                ),
                response: contactsCon.contactsResponse,
                itemBuilder: (context, _, contact) => ContactCard(contact),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            heroTag: ContactsScreen.id,
            onPressed: () => Navigator.pushNamed(
              context,
              AddContactScreen.id,
            ),
          ),
        ),
      ),
    );
  }
}
