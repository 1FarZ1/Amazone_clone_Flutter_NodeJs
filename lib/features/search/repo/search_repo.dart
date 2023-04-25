import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api_service.dart';
import '../../../core/errors/failire.dart';
import '../../../core/utils/type_def.dart';
import '../../../models/product.dart';

abstract class SearchRepo {
  FutureEither<List<Product>> fetchSearchProducts({required String token, required String searchQuery});
}

class SearchRepoImpl implements SearchRepo {
  SearchRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither<List<Product>> fetchSearchProducts({required String token, required String searchQuery}) async {
    try {
      List<Product> listProducts = [];
      var res = await apiService.getSearchProducts(token: token, searchQuery: searchQuery);
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
