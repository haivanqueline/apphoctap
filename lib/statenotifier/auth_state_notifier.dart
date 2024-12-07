import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user.dart';
import '../providers/auth_repository_provider.dart';
import '../repository/auth_repository.dart';

enum RegisterStatus { initial, loading, success, error }

class AuthState {
  final RegisterStatus status;
  final User? user;
  final String? error;

  AuthState({
    this.status = RegisterStatus.initial,
    this.user,
    this.error,
  });

  AuthState copyWith({
    RegisterStatus? status,
    User? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthStateNotifier(this.authRepository) : super(AuthState()) {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final user = await authRepository.getUserFromLocal();
    if (user != null) {
      state = state.copyWith(
        status: RegisterStatus.success,
        user: user,
      );
    }
  }

  Future<void> registerUser(User user) async {
    state = state.copyWith(status: RegisterStatus.loading);
    try {
      final response = await authRepository.register(user);
      if (response['success'] == true && response['user'] != null) {
        var userData = response['user'];
        userData['photo'] = userData['photo'] ?? 'assets/default_avatar.png';

        final registeredUser = User.fromJson(userData);
        state = state.copyWith(
          status: RegisterStatus.success,
          user: registeredUser,
        );
      } else {
        state = state.copyWith(
            status: RegisterStatus.error,
            error: response['message'] ?? "Registration failed");
        throw Exception(state.error);
      }
    } catch (e) {
      state = state.copyWith(status: RegisterStatus.error, error: e.toString());
      throw e;
    }
  }

  Future<bool> isUserInitialized() async {
    if (state.user != null) return true;

    final user = await authRepository.getUserFromLocal();
    if (user != null) {
      state = state.copyWith(
        status: RegisterStatus.success,
        user: user,
      );
      return true;
    }
    return false;
  }
}

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => AuthStateNotifier(ref.read(authRepositoryProvider)),
);
