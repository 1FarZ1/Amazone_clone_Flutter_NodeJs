import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/features/home/repo/home_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';

final homeControllerProvider =
    StateNotifierProvider<HomeController, AsyncValue>((ref) {
  return HomeController(homeRepoImpl: ref.watch(homeRepoProvider), ref: ref);
});

class HomeController extends StateNotifier<AsyncValue<Product?>> {
  HomeController({required this.homeRepoImpl, required this.ref})
      : super(const AsyncData(null));
  final HomeRepoImpl homeRepoImpl;
  final StateNotifierProviderRef ref;
  String searchQuery = '';

  void getDealOfTheDay() async {
    state = const AsyncLoading<Product?>();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    await homeRepoImpl.getDealOfTheDay(token: token ?? "").then((value) {
      value.fold((failure) {
        state = AsyncValue.error(failure.errorMessage, StackTrace.empty);
      }, (products) {
        state = AsyncValue.data(products);
      });
    });
  }
}
