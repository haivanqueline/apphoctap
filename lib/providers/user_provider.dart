import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final currentUserProvider = StateProvider<User?>((ref) => null);