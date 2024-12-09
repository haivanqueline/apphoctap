import 'package:riverpod/riverpod.dart';

import '../repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});
