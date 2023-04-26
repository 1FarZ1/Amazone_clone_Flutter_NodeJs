import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api_service.dart';
import '../../../core/errors/failire.dart';
import '../../../core/utils/type_def.dart';
import '../../../models/user.dart';

abstract class CartRepo {
  FutureEither removeFromCart(
      {required String token, required String productId});
}

class CartRepoImpl implements CartRepo {
  CartRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither removeFromCart(
      {required String token, required String productId}) async {
    try {
      var res = await apiService.removeFromCart(
        token: token,
        productId: productId,
      );
      var data = User.fromMap(res);
      return Right(data);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
