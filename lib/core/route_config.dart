import 'package:amazon_clone/features/auth/view/login/login_view.dart';
import 'package:amazon_clone/features/home/home_view.dart';
import 'package:amazon_clone/features/splash/splash_view.dart';
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
          return const LoginView();
        }),
    GoRoute(
        path: "/home",
        builder: (context, state) {
          ;
          return const HomeView();
        }),

  ]);
}
