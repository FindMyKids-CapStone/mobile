import 'package:app_parent/config/app_key.dart';
import 'package:app_parent/service/graphql.dart';
import 'package:app_parent/service/spref.dart';
import 'package:app_parent/src/auth_page/auth_page.dart';
import 'package:app_parent/src/room_page/room_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final String _token = SPref.instance.get(AppKey.authorization);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLHelper.initializeClient(_token),
      child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const GetMaterialApp(
                  debugShowCheckedModeBanner: false, home: RoomPage());
            } else {
              return const GetMaterialApp(
                  debugShowCheckedModeBanner: false, home: AuthPage());
            }
          }),
    );
  }
}
