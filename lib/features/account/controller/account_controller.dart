import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/features/account/repo/account_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountControllerProvider =
    StateNotifierProvider<AccountController, AsyncValue>((ref) {
  return AccountController(
      accountRepo: ref.watch(accountRepoProvider), ref: ref);
});

class AccountController extends StateNotifier<AsyncValue> {
  AccountController({required this.accountRepo, required this.ref})
      : super(const AsyncData(null));
  final AccountRepo accountRepo;
  final StateNotifierProviderRef ref;

  void getOrders() async {
    state = const AsyncLoading();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    var res = await accountRepo.getOrders(
      token: token ?? "",
    );

    res.fold((l) {
      state = AsyncValue.error(l.errorMessage, StackTrace.empty);
    }, (r) {
      ref.read(userStateProvider.notifier).setUser(r);
      state = const AsyncValue.data('success');
    });
  }

  void logOut() async {
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      pref.setString("x-auth-token", "");
    });

    ref.read(userStateProvider.notifier).removeUser();
  }
}
