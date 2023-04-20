import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class AppConfig {
  static GoRouter route = GoRouter(routes: [
    GoRoute(
        path: "/",
        builder: (context, state) {
          return  Container();
        }),
  ]);
}
