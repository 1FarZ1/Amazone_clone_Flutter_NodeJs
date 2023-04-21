import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/controller/auth_controller.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed((const Duration(seconds: 2)), () {
      // ref.watch(authStateProvider) == AuthStatus.notLoggedIn ?  
      // GoRouter.of(context).push("/login") : GoRouter.of(context).push("/home");
      GoRouter.of(context).push("/login");
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text("Splash Screen"),
    ));
  }
}
