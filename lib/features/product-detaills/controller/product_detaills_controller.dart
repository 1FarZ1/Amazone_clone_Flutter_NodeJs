import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/features/product-detaills/repo/product_detaills_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';

final productDetaillsControllerProvider =
    StateNotifierProvider<ProductDetaillsController, AsyncValue>((ref) {
  return ProductDetaillsController(
      productDetaillsRepoImpl: ref.watch(productDetaillsRepoProvider),
      ref: ref);
});

class ProductDetaillsController extends StateNotifier<AsyncValue<Product?>> {
  ProductDetaillsController(
      {required this.productDetaillsRepoImpl, required this.ref})
      : super(const AsyncData(null));
  final ProductDetaillsRepoImpl productDetaillsRepoImpl;
  final StateNotifierProviderRef ref;

  void rateProduct({required double rating}) async {
    var temp = state.value!.id;
    state = const AsyncLoading<Product>();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    var res = await productDetaillsRepoImpl.rateProduct(
      productId: temp ?? "",
      token: token ?? "",
      rating: rating,
    );

    res.fold((l) {
      state = AsyncValue.error(l.errorMessage, StackTrace.empty);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
  void addToCart() async {
    var temp = state.value!.id;
    state = const AsyncLoading<Product>();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    var res = await productDetaillsRepoImpl.addToCart(
      productId: temp ?? "",
      token: token ?? "",

    );

    res.fold((l) {
      state = AsyncValue.error(l.errorMessage, StackTrace.empty);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }



  void setProduct(Product product) {
    state = AsyncValue.data(product);
  }
}
