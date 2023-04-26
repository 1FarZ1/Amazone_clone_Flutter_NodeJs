import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/core/theme/theme.dart';
import 'package:amazon_clone/features/admin/add_product/view/add_product_view.dart';
import 'package:amazon_clone/features/admin/view/admin_view.dart';
import 'package:amazon_clone/features/adress/view/adress_view.dart';
import 'package:amazon_clone/features/account/view/order_detaills.dart';
import 'package:amazon_clone/features/auth/controller/auth_controller.dart';
import 'package:amazon_clone/features/category/view/category_view.dart';
import 'package:amazon_clone/features/home/view/test_view.dart';
import 'package:amazon_clone/features/product-detaills/view/product_detaills_view.dart';
import 'package:amazon_clone/features/search/view/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/view/login/login_view.dart';
import 'features/splash/splash_view.dart';
import 'models/order.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();

  Future getData(ProviderContainer ref) {
    return ref.read(authControllerProvider.notifier).getUserData();
  }

  await getData(container);

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
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
            var isUserLoggedIn = ref.watch(userStateProvider.notifier
                .select((value) => value.isUserLoggedIn()));
            var typeUser =
                ref.watch(userStateProvider.select((value) => value.type));
            if (!isUserLoggedIn) {
              return "/login";
            } else {
              if (typeUser == "admin") {
                return "/admin";
              } else {
                return "/home";
              }
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
              return const TestView();
            }),
        GoRoute(
            path: "/admin",
            builder: (context, state) {
              return const AdminView();
            }),
        GoRoute(
            path: "/add-product",
            builder: (context, state) {
              return const AddProductScreen();
            }),
        GoRoute(
            path: "/category",
            builder: (context, state) {
              return CategoryDealsScreen(
                category: state.extra as String,
              );
            }),
        GoRoute(
            path: "/search",
            builder: (context, state) {
              return const SearchView();
            }),
        GoRoute(
            path: "/product-detaills",
            builder: (context, state) {
              return const ProductDetailScreen();
            }),
        GoRoute(
            path: "/adress",
            builder: (context, state) {
              return AdressView(totalAmount: state.extra as String);
            }),
        GoRoute(
            path: "/order-detaills",
            builder: (context, state) {
              return OrderDetailScreen(order: state.extra as Order);
            }),
      ]),
      theme: AppTheme.customTheme,
    );
  }
}
