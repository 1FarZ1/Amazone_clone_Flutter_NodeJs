import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/features/add_product/repo/add_product_repo.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addProductControllerProvider =
    StateNotifierProvider<AddProductController, AsyncValue>((ref) {
  return AddProductController(
      addProductRepoImpl: ref.watch(addProductRepoProvider), ref: ref);
});

class AddProductController extends StateNotifier<AsyncValue> {
  AddProductController({required this.addProductRepoImpl, required this.ref})
      : super(const AsyncData(null));
  final AddProductRepoImpl addProductRepoImpl;
  final StateNotifierProviderRef ref;

  void addProduct(
      {required name,
      required description,
      required quantity,
      required images,
      required String category,
      required double price,
      required BuildContext context}) async {
    state = const AsyncLoading<void>();
    String? token;

    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });

    state = await AsyncValue.guard(() => addProductRepoImpl.addProduct(
        token: token,
        name: name,
        images: images,
        quantity: quantity,
        description: description,
        category: category,
        price: price));
  }
}
