class User {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? birthday;

  User({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
  });

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    birthday = json['birthday'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['birthday'] = birthday;
    data['email'] = email;
    return data;
  }
}
