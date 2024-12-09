import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../providers/auth_repository_provider.dart';
import '../repository/auth_repository.dart';

enum RegisterStatus { initial, loading, success, error }

class AuthStateNotifier extends StateNotifier<RegisterStatus> {
  final AuthRepository authRepository;

  AuthStateNotifier(this.authRepository) : super(RegisterStatus.initial);

  Future<void> registerUser(User user) async {
    state = RegisterStatus.loading; // Đang đăng ký
    try {
      print('StateNotify registeruser');
      await authRepository.register(user);
      state = RegisterStatus.success; // Đang đăng ký
    } catch (e) {
      state = RegisterStatus.error; // Đang đăng ký
      throw e;
    }
  }
}

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, RegisterStatus>(
  (ref) => AuthStateNotifier(ref.read(authRepositoryProvider)),
);
