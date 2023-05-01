import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/product.dart';

final productStProvider = StateNotifierProvider<ProductSt, List<Product>>((ref) {
  return ProductSt();
});

class ProductSt extends StateNotifier<List<Product>> {
  ProductSt() : super([]);

  void addProduct(Product p) async {
    state.add(p);
  }

  void removeProduct(Product p) async {
    state.remove(p);
  }
   
  void updateProduct(Product p) async {
    state.where((element) {
      if (element.id == p.id) {
        element = p;
      }
      return true;
    });
  }
}
