import 'package:app_parent/service/spref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../config/app_key.dart';

class AuthController extends GetxController {
  User? currentUser;

  login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      var signIn = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (signIn.user != null) {
        String? token = await signIn.user?.getIdToken();
        await initDataAfterLoggedIn(token);
        update();
      }
    } catch (err) {
      print(err);
    }
  }

  initDataAfterLoggedIn(String? token) async {
    await SPref.instance.set(AppKey.authorization, token ?? "");
    await getUserFirebase();
  }

  getUserFirebase() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        currentUser = user;
        print("User $user");
      }
    });
  }
}
