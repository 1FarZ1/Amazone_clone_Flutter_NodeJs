import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api_service.dart';
import '../../../core/errors/failire.dart';
import '../../../core/utils/type_def.dart';
import '../../../models/product.dart';

abstract class CategoryRepo {
  FutureEither<List<Product>> fetchCategoryProducts(
      {required String token, required String category});
}

class CategoryRepoImpl implements CategoryRepo {
  CategoryRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither<List<Product>> fetchCategoryProducts(
      {required String token, required String category}) async {
    try {
      List<Product> listProducts = [];
      var res = await apiService.getCategoryProducts(
          token: token, category: category);
      for (var i in res["products"]) {
        listProducts.add(Product.fromMap(i));
      }
      return Right(listProducts);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
