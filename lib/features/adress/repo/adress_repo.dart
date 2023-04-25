import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/api_service.dart';
import '../../../core/errors/failire.dart';
import '../../../core/utils/type_def.dart';
import '../../../models/user.dart';

abstract class AddressRepo {

  FutureEither saveUserAdress({required String token, required String adress});
  FutureEither placeOrder({required String token, required String adress,required amount,required cart});
}

class AddressRepoImpl implements AddressRepo {
  AddressRepoImpl({required this.apiService});
  final ApiService apiService;

  @override
  FutureEither saveUserAdress(
      {required String token, required String adress}) async {
    try {
      var res = await apiService.saveUserAdress(
        token: token,
        adress: adress,
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
  @override
  FutureEither placeOrder(
      {required String token, required String adress,required amount,required cart}) async {
    try {
      var res = await apiService.placeOrder(
        token: token,
        adress: adress,
        amount:amount,
        cart: cart
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
