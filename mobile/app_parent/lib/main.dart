import 'package:app_parent/src/map_page/map_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
                home: Scaffold(
                    body: Center(child: Text('App is being initialized'))));
          } else if (snapshot.hasError) {
            return const MaterialApp(
                home: Scaffold(
                    body: Center(child: Text('An error has been occurred'))));
          }
          return const MaterialApp(
              debugShowCheckedModeBanner: false, home: MapPage());
        });
  }
}
