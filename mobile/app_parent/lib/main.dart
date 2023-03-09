import 'package:app_parent/src/profile_page/profile_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(
          birthday: DateTime.now(),
          email: "dump@gmail.com",
          name: "Dump",
          phone: "0123456789"),
    );
  }
}
