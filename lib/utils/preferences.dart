import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  setNotif(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('NOTIFICATION', value);
  }

  Future<bool> getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("NOTIFICATION") ?? false;
  }
}
