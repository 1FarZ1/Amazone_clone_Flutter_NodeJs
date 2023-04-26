import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api_service.dart';
import '../../../core/errors/failire.dart';
import '../../../core/utils/type_def.dart';
import '../../../models/user.dart';

abstract class AccountRepo {
  FutureEither getOrders(
      {required String token});
}

class AccountRepoImpl implements AccountRepo {
  AccountRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither getOrders(
      {required String token}) async {
    try {
      var res = await apiService.getOrders(
        token: token,
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
