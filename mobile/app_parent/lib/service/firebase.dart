import 'package:app_parent/service/spref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseHelper {
  static final FirebaseAuth instance = FirebaseAuth.instance;
  static Future<UserCredential> createUserWithEmailAndPassword(
      email, password) async {
    UserCredential userCredential = await instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  void getToken() async {
    await FirebaseMessaging.instance
        .getToken(
            vapidKey:
                "AAAASM7uuwE:APA91bGTG05sDzIlu91OQhKT6LUdg-F7BesGoYV-D1_7MqoT49oGfJ2HfblZwCIGVs7rxr8g6B06aB-5CtHvwEI21Jq0ibAI0-JwO-9lbRwwAT9dDE3ztf3rBjvqtEf8Qhcb1c54CRAK")
        .then((token) {
      print("My token is $token");
      SPref.instance.set("Authorizarion", token ?? "");
    });
  }
}
