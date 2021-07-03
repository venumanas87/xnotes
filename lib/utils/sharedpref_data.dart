import 'package:shared_preferences/shared_preferences.dart';
import 'package:xnotes/models/login_data.dart';

class SharedPref {
  static String UID = "uid";
  static String PASS = "password";

  saveAppState(String uid,String pass) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(UID,uid);
    sp.setString(PASS, pass);
  }

  Future<User> getAppState() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String id = sp.getString(UID);
    String pass = sp.getString(PASS);
    return new User(id,pass);
  }
}