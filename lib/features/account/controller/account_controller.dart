import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/features/account/repo/account_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';

final accountControllerProvider =
    StateNotifierProvider<AccountController, AsyncValue>((ref) {
  return AccountController(accountRepoImpl: ref.watch(accountRepoProvider), ref: ref);
});

class AccountController extends StateNotifier<AsyncValue> {
  AccountController({required this.accountRepoImpl, required this.ref})
      : super(const AsyncData(null));
  final AccountRepoImpl accountRepoImpl;
  final StateNotifierProviderRef ref;

  void getOrders() async {
    state = const AsyncLoading();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    var res = await accountRepoImpl.getOrders(
      token: token ?? "",
    );

    res.fold((l) {
      state = AsyncValue.error(l.errorMessage, StackTrace.empty);
    }, (r) {
      ref.read(userStateProvider.notifier).setUser(r);
      state = const AsyncValue.data('success');
    });
  }
}
