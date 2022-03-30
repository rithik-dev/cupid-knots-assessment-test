import 'dart:async';

import 'package:cupid_knot_assessment_test/models/contact.dart';
import 'package:cupid_knot_assessment_test/repositories/contacts_repository.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:paginated_items_builder/paginated_items_builder.dart';
import 'package:provider/provider.dart';

class ContactsController extends ChangeNotifier {
  PaginatedItemsResponse<Contact>? _contactsResponse;

  static ContactsController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<ContactsController>(context, listen: listen);

  PaginatedItemsResponse<Contact>? get contactsResponse => _contactsResponse;

  Future<void> updateContacts({
    required String userId,
    bool reset = false,
    bool showLoaderOnReset = false,
  }) async {
    try {
      if (reset && showLoaderOnReset) {
        _contactsResponse = null;
        notifyListeners();
      }

      final res = await ContactsRepository.getContacts(userId);
      if (reset || _contactsResponse == null) {
        _contactsResponse = res;
      } else {
        _contactsResponse!.update(res);
      }
      notifyListeners();
    } catch (_) {
      showSnackBar('Something went wrong!');
    }
  }

  Future<bool> createContact({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    final success = await ContactsRepository.createContact(
      userId: userId,
      data: data,
    );
    await updateContacts(userId: userId, reset: true);
    return success;
  }

  Future<bool> deleteContact({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    final success = await ContactsRepository.deleteContact(
      userId: userId,
      data: data,
    );
    await updateContacts(userId: userId, reset: true);
    return success;
  }

  void clear() {
    _contactsResponse = null;
    notifyListeners();
  }
}
