import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repo/order_repo.dart';


final ordersControllerProvider =
    StateNotifierProvider<OrderController, AsyncValue>((ref) {
  return OrderController(orderRepoImpl: ref.watch(orderRepoProvider), ref: ref);
});

class OrderController extends StateNotifier<AsyncValue> {
  OrderController({required this.orderRepoImpl, required this.ref})
      : super(const AsyncData(null));
  final OrderRepoImpl orderRepoImpl;
  final StateNotifierProviderRef ref;

  void getAllOrders() async {
    state = const AsyncLoading();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    var res = await orderRepoImpl.getAllOrders(
      token: token ?? "",
    );

    res.fold((l) {
      state = AsyncValue.error(l.errorMessage, StackTrace.empty);
    }, (r) {
      state =  AsyncValue.data(r);
    });
  }
}
