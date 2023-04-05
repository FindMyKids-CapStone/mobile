import 'package:app_parent/service/graphql.dart';
import 'package:app_parent/service/spref.dart';
import 'package:app_parent/src/auth_page/auth_page.dart';
import 'package:app_parent/src/map_page/map_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting("vi");
  await SPref.init();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GraphQLHelper.initializeClient(),
      child: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const GetMaterialApp(
                  debugShowCheckedModeBanner: false, home: MapPage());
            } else {
              return const GetMaterialApp(
                  debugShowCheckedModeBanner: false, home: AuthPage());
            }
          }),
    );
  }
}
