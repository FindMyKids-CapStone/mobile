import 'dart:convert';

import 'package:app_parent/models/profile_model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Profile> getData() async {
  var client = http.Client();
  
    var res = await client.get(Uri.parse('http://10.124.7.242:8080/information'));
    var jsonBody = jsonDecode(res.body);
    return Profile.fromJson(jsonBody["data"]);
}