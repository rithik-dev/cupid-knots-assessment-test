class Contact {
  late final String id;
  late final String fullName;
  late final String contactNumber;
  late final String email;

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    fullName = json['full_name'];
    contactNumber = json['contact_number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json['full_name'] = fullName;
    _json['contact_number'] = contactNumber;
    _json['email'] = email;
    return _json;
  }
}
