
import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/features/posts/repo/posts_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';

final postControllerProvider =
    StateNotifierProvider<PostsController, AsyncValue>((ref) {
  return PostsController(postsRepoImpl: ref.watch(postsRepoProvider), ref: ref);
});

class PostsController extends StateNotifier<AsyncValue<List<Product>?>> {
  PostsController({required this.postsRepoImpl, required this.ref})
      : super(const AsyncData(null));
  final PostsRepoImpl postsRepoImpl;
  final StateNotifierProviderRef ref;

  Future<void> getPosts({required BuildContext context}) async {
    state = const AsyncLoading<List<Product>?>();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    await postsRepoImpl.getPosts(token: token ?? "").then((value) {
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
    await postsRepoImpl.deletePosts(token: token ?? "", id: id).then((value) {
      value.fold((failure) {
        state = AsyncValue.error(failure.errorMessage, StackTrace.empty);
      }, (products) {
        state = AsyncValue.data(products);
      });
    });
  }
}
