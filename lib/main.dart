import 'dart:developer';

import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/core/theme/theme.dart';
import 'package:amazon_clone/features/account/view/account_view.dart';
import 'package:amazon_clone/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'core/route_config.dart';
import 'features/auth/view/login/login_view.dart';
import 'features/home/view/home_view.dart';
import 'features/splash/splash_view.dart';
import 'models/user.dart';

// use ref here

void main() async {
  final container = ProviderContainer();

  Future getData(ProviderContainer ref) {
    return ref.read(authControllerProvider.notifier).getUserData();
  }

  final authState = await getData(container);

  WidgetsFlutterBinding.ensureInitialized();
  runApp(UncontrolledProviderScope(container: container, child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  bool isLoggedIn() {
    log("is Logged out : ${ref.watch(userStateProvider) != User.Empty()}");

    // ref.watch(authControllerProvider).when(data: data, error: error, loading: loading)

    return ref.watch(userStateProvider).equals(User.Empty());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(initialLocation: "/", routes: [
        GoRoute(
            path: "/",
            builder: (context, state) {
              return const SplashView();
            }),
        GoRoute(
          path: "/redirect",
          redirect: (context, state) {
            if (isLoggedIn()) {
              return "/login";
            } else {
              return "/home";
            }
          },
        ),
        GoRoute(
            path: "/login",
            builder: (context, state) {
              return const LoginView();
            }),
        GoRoute(
            path: "/home",
            builder: (context, state) {
              return const HomeView();
            }),
        GoRoute(
            path: "/account",
            builder: (context, state) {
              return const AccountView();
            }),
      ]),
      theme: AppTheme.customTheme,
    );
  }
}
