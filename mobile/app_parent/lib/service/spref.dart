import 'package:shared_preferences/shared_preferences.dart';

class SPref {
  static final SPref instance = SPref._internal();

  SPref._internal();

  static SharedPreferences? _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future set(String key, String value) async {
    late SharedPreferences prefs;
    prefs = _prefs ?? await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  get(String key) {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    return _prefs?.get(key) ?? "";
  }

  clear() {
    // _prefs?.clear();
    _prefs?.setString("Authorization", "");
  }

  Future remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
