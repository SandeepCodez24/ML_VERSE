import 'package:shared_preferences/shared_preferences.dart';

class AppFunction {
  AppFunction._();

  static Future<void> saveLoginStatus(
    bool status,
    String userName,
    String email,
  ) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isLoggedIn', status);
    await pref.setString('userName', userName);
    await pref.setString('email', email);
  }
}
