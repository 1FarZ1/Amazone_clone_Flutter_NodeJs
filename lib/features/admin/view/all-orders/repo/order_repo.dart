import 'package:amazon_clone/models/order.dart';
import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:dio/dio.dart';

import '../../../../../core/api_service.dart';
import '../../../../../core/errors/failire.dart';
import '../../../../../core/utils/type_def.dart';

abstract class OrderRepo {
  FutureEither getAllOrders({required String token});
}

class OrderRepoImpl implements OrderRepo {
  OrderRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither getAllOrders({required String token}) async {
    try {
      var res = await apiService.getAllOrders(
        token: token,
      );
      var data = [];
      for (var i in res) {
        data.add(Order.fromMap(i));
      }
      return Right(data);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
