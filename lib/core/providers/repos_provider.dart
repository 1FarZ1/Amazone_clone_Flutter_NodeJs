import 'package:amazon_clone/core/providers/api_service_provider.dart';
import 'package:amazon_clone/features/account/repo/account_repo.dart';
import 'package:amazon_clone/features/admin/add_product/repo/add_product_repo.dart';
import 'package:amazon_clone/features/admin/analytics/repo/analytics_repo.dart';
import 'package:amazon_clone/features/adress/repo/adress_repo.dart';
import 'package:amazon_clone/features/auth/repository/auth_repo.dart';
import 'package:amazon_clone/features/cart/repo/cart_repo.dart';
import 'package:amazon_clone/features/category/repo/category_repo.dart';
import 'package:amazon_clone/features/home/repo/home_repo.dart';
import 'package:amazon_clone/features/admin/posts/repo/posts_repo.dart';
import 'package:amazon_clone/features/product-detaills/repo/product_detaills_repo.dart';
import 'package:amazon_clone/features/search/repo/search_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/admin/all-orders/repo/order_repo.dart';

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
final productDetaillsRepoProvider = Provider<ProductDetaillsRepoImpl>((ref) {
  return ProductDetaillsRepoImpl(apiService: ref.read(apiServiceProvider));
});
final homeRepoProvider = Provider<HomeRepoImpl>((ref) {
  return HomeRepoImpl(apiService: ref.read(apiServiceProvider));
});
final cartRepoProvider = Provider<CartRepoImpl>((ref) {
  return CartRepoImpl(apiService: ref.read(apiServiceProvider));
});
final adressRepoProvider = Provider<AddressRepoImpl>((ref) {
  return AddressRepoImpl(apiService: ref.read(apiServiceProvider));
});
final accountRepoProvider = Provider<AccountRepoImpl>((ref) {
  return AccountRepoImpl(apiService: ref.read(apiServiceProvider));
});
final orderRepoProvider = Provider<OrderRepoImpl>((ref) {
  return OrderRepoImpl(apiService: ref.read(apiServiceProvider));
});
final analyticsRepoProvider = Provider<AnalyticsRepoImpl>((ref) {
  return AnalyticsRepoImpl(apiService: ref.read(apiServiceProvider));
});
