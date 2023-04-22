import 'dart:developer';

import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/core/utils/custom_snack_bar.dart';
import 'package:amazon_clone/features/auth/repository/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue>((ref) {
  return AuthController(authRepository: ref.watch(authRepoProvider), ref: ref);
});

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
        showSnackBar(context, failure.errorMessage);
      }, (user) {
        state = AsyncValue.data(user);

        ref.watch(sharedPreferenceProvider)?.then((pref) {
          pref.setString("x-auth-token", user.token);
        });
        ref.read(userStateProvider.notifier).setUser(user);
      });

      // GoRouter.of(context).push("/home");
    });
  }

  Future<void> getUserData() async {
    log("============================GET USER DATA CALLED=====================================");
    var token;

    ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
      if (token == null) {
        log("token is null");
        pref.setString('x-auth-token', '');
      }
      var res = await authRepository.getUserData(token: token);

      res.fold((failire) {
        log(failire.errorMessage.toUpperCase());
        state = AsyncValue.error(failire.errorMessage, StackTrace.current);
      }, (data) {
        log(data.toJson().toString());
        state = AsyncValue.data(data);
        ref.read(userStateProvider.notifier).setUser(data);
      });
    });
  }
}
