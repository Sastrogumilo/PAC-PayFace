import 'package:shared_preferences/shared_preferences.dart';

deleteAllSharedPreference() async {
  SharedPreferences pref =  await SharedPreferences.getInstance();
  pref.clear();
  print("Shared Preference telah dihapus ...");
  print("Menuju LogOut");
}