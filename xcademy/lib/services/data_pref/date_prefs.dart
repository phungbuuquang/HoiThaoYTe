import 'package:shared_preferences/shared_preferences.dart';

class DataPrefs {
  SharedPreferences shared;
  DataPrefs(this.shared);

  Future<bool> saveUserId(String id) async {
    return shared.setString('user_id', id);
  }

  String getUserId() {
    return shared.getString('user_id') ?? '';
  }

  Future<bool> saveUserName(String name) async {
    return shared.setString('user_name', name);
  }

  String getUserName() {
    return shared.getString('user_name') ?? '';
  }
}
