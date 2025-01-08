import 'package:hive/hive.dart';

class AuthLocalDataSource {
  final Box _userBox;

  AuthLocalDataSource(this._userBox);

  Future<void> saveUserData(Map<String, dynamic> data) async {
    await _userBox.put('user', data);
    //hi
  }

  Map<String, dynamic>? getUserData() {
    return _userBox.get('user');
  }

  Future<void> clearUserData() async {
    await _userBox.delete('user');
  }
}
