// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazon_clone/core/utils/type_def.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api_service.dart';
import '../../../core/errors/failire.dart';
import '../../../models/product.dart';

abstract class HomeRepo {
  FutureEither getDealOfTheDay({required token});
}

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  HomeRepoImpl({
    required this.apiService,
  });
  @override
  FutureEither getDealOfTheDay({required token}) async {
    try {
      var res = await apiService.getDealOfTheDay(token: token);
      var product = Product.fromMap(res);
      return Right(product);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
