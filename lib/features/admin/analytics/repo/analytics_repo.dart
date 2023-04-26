import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/api_service.dart';
import '../../../../core/errors/failire.dart';
import '../../../../core/utils/type_def.dart';
import '../../../../models/sales.dart';

abstract class AnalyticsRepo {
  FutureEither getAnalytics({required String token});
}

class AnalyticsRepoImpl implements AnalyticsRepo {
  AnalyticsRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither getAnalytics({required String token}) async {
    try {
      var res = await apiService.getAnalytics(
        token: token,
      );
      var totalEarning = res['totalEarnings'];
      var sales = [
        Sales('Mobiles', res['mobileEarnings']),
        Sales('Essentials', res['essentialEarnings']),
        Sales('Books', res['booksEarnings']),
        Sales('Appliances', res['applianceEarnings']),
        Sales('Fashion', res['fashionEarnings']),
      ];
      var temp = {'totalEarning': totalEarning, 'sales': sales};
      return Right(temp);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
