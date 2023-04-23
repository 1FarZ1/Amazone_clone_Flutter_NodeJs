import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api_service.dart';
import '../../../core/errors/failire.dart';
import '../../../core/utils/type_def.dart';
import '../../../models/product.dart';

abstract class PostsRepo {
  FutureEither<List<Product>> getPosts({required String token});
  FutureEither<List<Product>> deletePosts({required String token, required id});
}

class PostsRepoImpl implements PostsRepo {
  PostsRepoImpl({required this.apiService});
  final ApiService apiService;
  @override
  FutureEither<List<Product>> getPosts({required token}) async {
    try {
      List<Product> listProducts = [];
      var res = await apiService.getPosts(token: token);
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

  @override
  FutureEither<List<Product>> deletePosts(
      {required String token, required id}) async {
    try {
      List<Product> listProducts = [];
      var res = await apiService.deletePost(token: token, id: id);
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
