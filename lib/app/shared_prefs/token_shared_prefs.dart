// app/shared_prefs/token_shared_prefs.dart
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _prefs;

  TokenSharedPrefs(this._prefs);

  Future<void> saveToken(String token) async {
    await _prefs.setString('auth_token', token);
  }

  String? getToken() {
    return _prefs.getString('auth_token');
  }

  Future<void> clearToken() async {
    await _prefs.remove('auth_token');
  }
}
