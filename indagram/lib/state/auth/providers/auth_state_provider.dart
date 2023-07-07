import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/auth/models/auth_state.dart';
import 'package:indagram/state/auth/notifier/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
