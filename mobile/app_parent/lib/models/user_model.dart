import '../share/util_convert/datetime_convert.dart';

class UserModel {
  String? displayName;
  String? email;
  String? id;
  String? joinAt;
  String? phoneNumber;
  String? photoURL;
  String? role;

  UserModel(
      {this.id,
      this.displayName,
      this.email,
      this.joinAt,
      this.phoneNumber,
      this.photoURL,
      this.role});

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    displayName = json['displayName'] ?? json['name'];
    email = json['email'];
    joinAt = json['joinAt'] != null
        ? dateTimeConvertString(
            dateTime: utcToLocalDateTime(DateTime.parse(json['joinAt'])) ??
                DateTime.now(),
            dateType: "dd/MM/yyyy")
        : null;
    phoneNumber = json['phoneNumber'];
    photoURL = json['photoURL'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['displayName'] = displayName;
    map['email'] = email;
    map['joinAt'] = joinAt;
    map['phoneNumber'] = phoneNumber;
    map['photoURL'] = photoURL;
    map['role'] = role;
    return map;
  }
}
