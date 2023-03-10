import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Profile {
  String? fullName;
  String? phoneNumber;
  String? birthday;
  String? email;

  Profile({
    required this.fullName,
    required this.phoneNumber,
    required this.birthday,
    required this.email,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
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