import 'package:amazon_clone/core/providers/api_service_provider.dart';
import 'package:amazon_clone/features/add_product/repo/add_product_repo.dart';
import 'package:amazon_clone/features/auth/repository/auth_repo.dart';
import 'package:amazon_clone/features/category/repo/category_repo.dart';
import 'package:amazon_clone/features/posts/repo/posts_repo.dart';
import 'package:amazon_clone/features/search/repo/search_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider<AuthRepoImpl>((ref) {
  return AuthRepoImpl(ref.read(apiServiceProvider));
});
final addProductRepoProvider = Provider<AddProductRepoImpl>((ref) {
  return AddProductRepoImpl(apiService: ref.read(apiServiceProvider));
});
final postsRepoProvider = Provider<PostsRepoImpl>((ref) {
  return PostsRepoImpl(apiService: ref.read(apiServiceProvider));
});
final categoryRepoProvider = Provider<CategoryRepoImpl>((ref) {
  return CategoryRepoImpl(apiService: ref.read(apiServiceProvider));
});
final searchRepoProvider = Provider<SearchRepoImpl>((ref) {
  return SearchRepoImpl(apiService: ref.read(apiServiceProvider));
});
