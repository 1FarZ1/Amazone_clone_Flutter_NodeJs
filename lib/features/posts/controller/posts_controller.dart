import 'dart:developer';

import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/core/providers/user_provider.dart';
import 'package:amazon_clone/core/utils/custom_snack_bar.dart';
import 'package:amazon_clone/features/auth/repository/auth_repo.dart';
import 'package:amazon_clone/features/posts/repo/posts_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final postControllerProvider =
    StateNotifierProvider<PostsController, AsyncValue>((ref) {
  return PostsController(postsRepoImpl: ref.watch(postsRepoProvider), ref: ref);
});

class PostsController extends StateNotifier<AsyncValue> {
  PostsController({required this.postsRepoImpl, required this.ref})
      : super(const AsyncData(null));
  final PostsRepoImpl postsRepoImpl;
  final StateNotifierProviderRef ref;

  Future<void> getPosts({required BuildContext context}) async {
    state = const AsyncLoading<void>();
    var token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");

    });
    state = await AsyncValue.guard(() => postsRepoImpl.getPosts(token: token));
  }

  

  Future<void> deletePost({required BuildContext context,required id}) async {
    state = const AsyncLoading<void>();
    var token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");

    });
    state = await AsyncValue.guard(() => postsRepoImpl.deletePosts(token: token, id: id));
  }


}
