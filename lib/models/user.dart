class User {
  late final int id;
  late final String fullName;
  late final String email;
  late final String mobileNumber;
  late final String gender;
  late final String dateOfBirth;
  late final String accessToken;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    email = json['email'];
    mobileNumber = json['mobile_no'];
    gender = json['gender'];
    dateOfBirth = json['dob'];
    accessToken = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    _json['id'] = id;
    _json['full_name'] = fullName;
    _json['email'] = email;
    _json['mobile_no'] = mobileNumber;
    _json['gender'] = gender;
    _json['dob'] = dateOfBirth;
    _json['token'] = accessToken;
    return _json;
  }
}
