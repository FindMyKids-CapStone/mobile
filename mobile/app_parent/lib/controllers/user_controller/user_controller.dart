import 'dart:convert';

import 'package:app_parent/models/profile_model/user_model.dart';
import 'package:http/http.dart' as http;

Future<User> getData() async {
  var client = http.Client();

  var res = await client.get(Uri.parse('http://10.124.7.242:8080/information'));
  var jsonBody = jsonDecode(res.body);
  return User.fromJson(jsonBody["data"]);
}

Future<User?> register(email, pass, name) async {
  var client = http.Client();
  var res = await client.post(
    Uri.parse('http://123.30.234.181:8080/register'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': pass,
      'fullName': name,
      'role': "parent"
    }),
  );
  var jsonBody = jsonDecode(res.body);
  if (res.statusCode == 200 && jsonBody["error"] == null) {
    return User.fromJson(jsonBody["data"]);
  }
  return null;
}
