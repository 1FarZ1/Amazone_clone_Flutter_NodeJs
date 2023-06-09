import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/features/admin/analytics/repo/analytics_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final analyticsControllerProvider =
    StateNotifierProvider<AnalyticsController, AsyncValue>((ref) {
  return AnalyticsController(analyticsRepo: ref.watch(analyticsRepoProvider), ref: ref);
});

class AnalyticsController extends StateNotifier<AsyncValue> {
  AnalyticsController({required this.analyticsRepo, required this.ref})
      : super(const AsyncData(null));
  final AnalyticsRepo analyticsRepo;
  final StateNotifierProviderRef ref;

  void getAnalytics() async {
    state = const AsyncLoading();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    var res = await analyticsRepo.getAnalytics(
      token: token ?? "",
    );

    res.fold((l) {
      state = AsyncValue.error(l.errorMessage, StackTrace.empty);
    }, (r) {
      state =  AsyncValue.data(r);
    });
  }
}
