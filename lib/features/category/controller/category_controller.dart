import 'dart:developer';

import 'package:amazon_clone/core/providers/repos_provider.dart';
import 'package:amazon_clone/core/providers/shared_preference_provider.dart';
import 'package:amazon_clone/features/category/repo/category_repo.dart';
import 'package:amazon_clone/features/posts/repo/posts_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/product.dart';

final categoryControllerProvider =
    StateNotifierProvider<CategoryController, AsyncValue>((ref) {
  return CategoryController(categoryRepoImpl: ref.watch(categoryRepoProvider), ref: ref);
});

class CategoryController extends StateNotifier<AsyncValue<List<Product>?>> {
  CategoryController({required this.categoryRepoImpl, required this.ref})
      : super(const AsyncData(null));
  final CategoryRepoImpl categoryRepoImpl;
  final StateNotifierProviderRef ref;

  void fetchCategoryProducts(String category, BuildContext context) async {
    state = const AsyncLoading<List<Product>?>();
    String? token;
    await ref.watch(sharedPreferenceProvider)?.then((pref) async {
      token = pref.getString("x-auth-token");
    });
    await categoryRepoImpl.fetchCategoryProducts(token : token ?? "",category: category).then((value) {
      value.fold((failure) {
        print(failure.toString());
        state = AsyncValue.error(failure, StackTrace.empty);
      }, (products) {
        state = AsyncValue.data(products);
      });
    });
  }

}
