import 'package:amazon_clone/models/product.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api_service.dart';
import '../../../core/errors/failire.dart';
import '../../../core/utils/type_def.dart';

abstract class ProductDetaillsRepo {
  FutureEither rateProduct({required String token, required String productId,required double rating});
}

class ProductDetaillsRepoImpl implements ProductDetaillsRepo {
  ProductDetaillsRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither rateProduct({required String token, required String productId,required double rating}) async {
    try {
      var res = await apiService.rateProduct(token: token, productId: productId, rating: rating);
      return Right(res);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  
}
