import 'dart:developer';

import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/features/auth/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue>((ref) {
  return AuthController(authRepository: ref.watch(authRepoProvider), ref: ref);
});
final authStateProvider = Provider(
  (ref) {
    return ref
        .watch(sharedPreferenceProvider)
        .whenData((value) => value.get("x-auth-token"));
    ;
  },
);

class AuthController extends StateNotifier<AsyncValue> {
  AuthController({required this.authRepository, required this.ref})
      : super(const AsyncData(null));
  final AuthRepoImpl authRepository;
  final StateNotifierProviderRef ref;

  Future<void> register({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncLoading<void>();

    state = await AsyncValue.guard(() => authRepository.register(
          email: email,
          password: password,
          name: name,
        ));
  }

  Future<void> login(
      {required email, required password, required context}) async {
    state = const AsyncLoading<void>();
    await authRepository
        .login(
      email: email,
      password: password,
    )
        .then((value) {
      value.fold((failure) {
        state = AsyncValue.error(failure.errorMessage, StackTrace.current);
      }, (user) {
        log(user.toJson());
        state = AsyncValue.data(user);
        ref.read(userStateProvider.notifier).setUser(user);
        ref.read(sharedPreferenceProvider).whenData((value) {
          value.setString("x-auth-token", user.token);
        });
        Future.delayed(const Duration(seconds: 3), () {
          GoRouter.of(context).push("/home");
        });
      });
    });
  }
}
