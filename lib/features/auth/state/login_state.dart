import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:mini_job_portal_demo/features/auth/models/user_model.dart';
import '../data/auth_local_data_source.dart';

final loginStateProvider =
    StateNotifierProvider<LoginController, AsyncValue<void>>(
      (ref) => LoginController(AuthLocalDataSource()),
    );

class LoginController extends StateNotifier<AsyncValue<void>> {
  final AuthLocalDataSource _localDataSource;

  LoginController(this._localDataSource) : super(const AsyncData(null));

  Future<bool> login(String email, String password) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));

    final user = UserModel(
      email: email,
      password: password,
      token: 'mockToken',
    );
    await _localDataSource.saveUser(user);

    state = const AsyncData(null);
    return true;
  }
}
