import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/api_service.dart';
import '../../../../core/errors/failire.dart';
import '../../../../core/utils/type_def.dart';


abstract class AnalyticsRepo {
  FutureEither getAnalytics(
      {required String token});
}

class AnalyticsRepoImpl implements AnalyticsRepo {
  AnalyticsRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither getAnalytics(
      {required String token}) async {
    try {
      var res = await apiService.getAnalytics(
        token: token,
      );
      return Right(res);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
