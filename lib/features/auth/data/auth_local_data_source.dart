import 'package:hive_flutter/hive_flutter.dart';
import 'package:mini_job_portal_demo/features/auth/models/user_model.dart';
import '../../../core/services/secure_storage_service.dart';

class AuthLocalDataSource {
  final _userBox = Hive.box('userBox');
  final SecureStorageService _secureStorage = SecureStorageService();

  Future<void> saveUser(UserModel user) async {
    await _userBox.put('user', user.toJson());
    await _secureStorage.write('token', user.token ?? '');
  }

  UserModel? getUser() {
    final data = _userBox.get('user');
    if (data == null) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(data));
  }

  Future<void> logout() async {
    await _secureStorage.delete('token');
    await _userBox.delete('user');
  }
}
