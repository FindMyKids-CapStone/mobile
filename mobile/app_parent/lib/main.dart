import 'package:app_parent/service/graphql.dart';
import 'package:app_parent/service/spref.dart';
import 'package:app_parent/src/auth_page/auth_page.dart';
import 'package:app_parent/src/room_page/room_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting("vi");
  await SPref.init();
  runApp(MaterialApp(
    home: const MyApp(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepPurple),
  ));
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
              return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: const RoomPage(),
                  theme: ThemeData(
                      primarySwatch: Colors.indigo,
                      fontFamily: GoogleFonts.rubik().fontFamily));
            } else {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: const AuthPage(),
                theme: ThemeData(
                    primarySwatch: Colors.indigo,
                    fontFamily: GoogleFonts.rubik().fontFamily),
              );
            }
          }),
    );
  }
}
