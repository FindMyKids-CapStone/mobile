import 'package:firebase_auth/firebase_auth.dart';

class Room {
  String? id;
  String? name;
  String? createdAt;
  String? createdBy;
  String? code;
  User? user;

  Room(
      {this.id,
      this.name,
      this.createdAt,
      this.createdBy,
      this.code,
      this.user});

  Room.fromJson(dynamic json) {
    id = json['id'];
    createdAt = json['createdAt'];
    name = json['name'];
    createdBy = json['createdBy'];
    code = json['code'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['createdAt'] = createdAt;
    map['name'] = name;
    map['createdBy'] = createdBy;
    map['code'] = code;
    map['user'] = user;
    return map;
  }
}
