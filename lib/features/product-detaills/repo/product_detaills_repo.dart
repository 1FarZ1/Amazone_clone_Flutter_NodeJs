import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api_service.dart';
import '../../../core/errors/failire.dart';
import '../../../core/utils/type_def.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';

abstract class ProductDetaillsRepo {
  FutureEither<Product> rateProduct(
      {required String token,
      required String productId,
      required double rating});
  FutureEither addToCart({required String token, required String productId});
}

class ProductDetaillsRepoImpl implements ProductDetaillsRepo {
  ProductDetaillsRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither<Product> rateProduct(
      {required String token,
      required String productId,
      required double rating}) async {
    try {
      var res = await apiService.rateProduct(
          token: token,
          productId: productId,
          rating: rating.toStringAsFixed(0));
      var data = Product.fromMap(res);
      return Right(data);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  FutureEither addToCart(
      {required String token, required String productId}) async {
    try {
      var res = await apiService.addToCart(
        token: token,
        productId: productId,
      );
      var data= User.fromMap(res);
      return Right(data);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
