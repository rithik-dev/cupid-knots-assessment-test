import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupid_knot_assessment_test/models/contact.dart';
import 'package:cupid_knot_assessment_test/utils/globals.dart';
import 'package:paginated_items_builder/paginated_items_builder.dart';

class ContactsRepository {
  const ContactsRepository._();

  static final _usersCollection = Globals.firestore.collection('users');

  static Future<bool> createContact({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _usersCollection.doc(userId).set({
        'contacts': FieldValue.arrayUnion([data]),
      }, SetOptions(merge: true));
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<PaginatedItemsResponse<Contact>?> getContacts(
    String userId,
  ) async {
    final userDoc = await _usersCollection.doc(userId).get();

    if (!userDoc.exists) {
      return PaginatedItemsResponse(
        listItems: [],
        idGetter: (contact) => contact.id,
      );
    }

    final data = userDoc.data();

    final contacts = List.generate(data!['contacts'].length, (index) {
      final json = data['contacts'][index];
      json['id'] = index;
      return Contact.fromJson(json);
    });

    return PaginatedItemsResponse<Contact>(
      listItems: contacts,
      idGetter: (contact) => contact.id,
    );
  }

  static Future<bool> deleteContact({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _usersCollection.doc(userId).update({
        'contacts': FieldValue.arrayRemove([data]),
      });
      return true;
    } catch (_) {
      return false;
    }
  }
}
