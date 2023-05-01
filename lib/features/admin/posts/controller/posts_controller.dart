
import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../models/product.dart';
import '../repo/posts_repo.dart';

final postControllerProvider =
    StateNotifierProvider<PostsController, AsyncValue>((ref) {
  return PostsController(postsRepo: ref.watch(postsRepoProvider), ref: ref);
});

class PostsController extends StateNotifier<AsyncValue<List<Product>?>> {
  PostsController({required this.postsRepo, required this.ref})
      : super(const AsyncData(null));
  final PostsRepo postsRepo;
  final StateNotifierProviderRef ref;

  Future<void> getPosts({required BuildContext context}) async {
    state = const AsyncLoading<List<Product>?>();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    await postsRepo.getPosts(token: token ?? "").then((value) {
      value.fold((failure) {
        state = AsyncValue.error(failure, StackTrace.empty);
      }, (products) {
        state = AsyncValue.data(products);
      });
    });
  }

  Future<void> deletePost({required BuildContext context, required id}) async {
    state = const AsyncLoading<List<Product>?>();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    await postsRepo.deletePosts(token: token ?? "", id: id).then((value) {
      value.fold((failure) {
        state = AsyncValue.error(failure.errorMessage, StackTrace.empty);
      }, (products) {
        state = AsyncValue.data(products);
      });
    });
  }
}
