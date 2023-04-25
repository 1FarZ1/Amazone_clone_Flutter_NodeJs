import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/features/product-detaills/repo/product_detaills_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';
import '../repo/cart_repo.dart';

final cartControllerProvider =
    StateNotifierProvider<CartController, AsyncValue>((ref) {
  return CartController(
      cartRepoImpl: ref.watch(cartRepoProvider),
      ref: ref);
});

class CartController extends StateNotifier<AsyncValue> {
  CartController(
      {required this.cartRepoImpl, required this.ref})
      : super(const AsyncData(null));
  final CartRepoImpl cartRepoImpl;
  final StateNotifierProviderRef ref;

  void removeFromCart({required Product product}) async {
    state = const AsyncLoading();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    var res = await cartRepoImpl.removeFromCart(
      productId: product.id ?? "",
      token: token ?? "",
    );

    res.fold((l) {
      state = AsyncValue.error(l.errorMessage, StackTrace.empty);
    }, (r) {
      ref.read(userStateProvider.notifier).setUser(r);
      state = const AsyncValue.data('success');
    });
  }

  void setProduct(Product product) {
    state = AsyncValue.data(product);
  }
}
