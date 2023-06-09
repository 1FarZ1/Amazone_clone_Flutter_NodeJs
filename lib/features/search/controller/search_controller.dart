import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/features/search/repo/search_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';

final searchControllerProvider =
    StateNotifierProvider<SearchController, AsyncValue>((ref) {
  return SearchController(
      searchRepo: ref.watch(searchRepoProvider), ref: ref);
});

class SearchController extends StateNotifier<AsyncValue<List<Product>?>> {
  SearchController({required this.searchRepo, required this.ref})
      : super(const AsyncData(null));
  final SearchRepo searchRepo;
  final StateNotifierProviderRef ref;
  String searchQuery = '';

  void fetchSearchProducts() async {
    state = const AsyncLoading<List<Product>?>();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    await searchRepo
        .fetchSearchProducts(token: token ?? "", searchQuery: searchQuery)
        .then((value) {
      value.fold((failure) {
        state = AsyncValue.error(failure.errorMessage, StackTrace.empty);
      }, (products) {
        state = AsyncValue.data(products);
      });
    });
  }
}
