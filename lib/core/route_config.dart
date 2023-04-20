import 'package:amazon_clone/features/auth/view/login_page_view.dart';
import 'package:amazon_clone/features/splash/splash_view.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class AppConfig {
  static GoRouter route = GoRouter(routes: [
    GoRoute(
        path: "/",
        builder: (context, state) {
          ;
          return const SplashView();
        }),
    GoRoute(
        path: "/login",
        builder: (context, state) {
          ;
          return const LoginPageView();
        }),
  ]);
}
