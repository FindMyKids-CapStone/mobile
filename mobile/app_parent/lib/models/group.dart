import 'package:app_parent/models/user_model.dart';

import '../share/util_convert/datetime_convert.dart';

class Group {
  String? id;
  String? name;
  String? createdAt;
  String? createdBy;
  String? code;
  String? imgUrl;
  List<UserModel>? users;

  Group(
      {this.id,
      this.name,
      this.createdAt,
      this.createdBy,
      this.code,
      this.users});

  Group.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'] != null
        ? dateTimeConvertString(
            dateTime: utcToLocalDateTime(DateTime.parse(json['createdAt'])) ??
                DateTime.now(),
            dateType: "dd/MM/yyyy HH:mm")
        : null;
    name = json['name'];
    createdBy = json['createdBy'];
    code = json['code'];
    users = json['users'] != null
        ? List<UserModel>.from(json['users'].map((d) => UserModel.fromJson(d)))
        : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['name'] = name;
    map['createdBy'] = createdBy;
    map['code'] = code;
    map['user'] = users;
    return map;
  }
}
