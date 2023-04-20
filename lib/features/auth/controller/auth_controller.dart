



import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/features/auth/repository/auth_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue>(
        (ref) {
  return AuthController(
    authRepository: ref.watch(authRepoProvider),
  );
});
class AuthController extends StateNotifier<AsyncValue> {
  AuthController({required this.authRepository})
      : super(const AsyncData(null));
  final AuthRepoImpl authRepository;

  Future<void> signInAnonymously() async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard(authRepository.login);
  }
}