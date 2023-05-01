import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/features/adress/repo/adress_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addressControllerProvider =
    StateNotifierProvider<AddressController, AsyncValue>((ref) {
  return AddressController(
      orderRepo: ref.watch(adressRepoProvider), ref: ref);
});

class AddressController extends StateNotifier<AsyncValue> {
  AddressController({required this.orderRepo, required this.ref})
      : super(const AsyncData(null));
  final AddressRepo orderRepo;
  final StateNotifierProviderRef ref;

  void saveUserAddress({required adress}) async {
    state = const AsyncLoading();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    var res = await orderRepo.saveUserAdress(
      adress: adress ?? "",
      token: token ?? "",
    );

    res.fold((l) {
      state = AsyncValue.error(l.errorMessage, StackTrace.empty);
    }, (r) {
      ref.read(userStateProvider.notifier).setUser(r);
      state = const AsyncValue.data('success');
    });
  }

  void placeOrder({required adress, required amount}) async {
    state = const AsyncLoading();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    var cart = ref.read(userStateProvider).cart;
    var res = await orderRepo.placeOrder(
        adress: adress ?? "", token: token ?? "", amount: amount, cart: cart);

    res.fold((l) {
      state = AsyncValue.error(l.errorMessage, StackTrace.empty);
    }, (r) {
      ref.read(userStateProvider).copyWith(
          cart: [],
      );
      ref.read(userStateProvider.notifier).setUser(r);
      state = const AsyncValue.data('success');
    });
  }
}
