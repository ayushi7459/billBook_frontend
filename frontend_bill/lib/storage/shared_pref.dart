import 'package:shared_preferences/shared_preferences.dart';

Future<String> saveImagePath(String path) async {
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setString('save_image', path);
  return 'Saved';
}

Future<String?> getImagePath() async {
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  return sharedPref.getString('save_image');
}

Future<String> removeImage() async {
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  await sharedPref.remove('save_image');
  return 'Removed';
}

Future<void> saveCredentials(String email, String password) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', email);
  await prefs.setString('password', password);
}

Future<void> saveUserName(String userName) async {
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  await sharedPref.setString('user_user_name', userName);
}

Future<void> saveMobileGender(String mobile, String gender) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("mobile", mobile);
  await prefs.setString("gender", gender);
}

Future<String?> getSavedEmail() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

Future<String?> getSavedPassword() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('password');
}

Future<void> clearCredentials() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('email');
  await prefs.remove('password');
}
