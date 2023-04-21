import 'dart:developer';

import 'package:amazon_clone/core/api_service.dart';
import 'package:amazon_clone/core/errors/failire.dart';
import 'package:amazon_clone/core/utils/type_def.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../models/user.dart';

abstract class AuthRepo {
  Future login({required email, required password});
  Future register({required email, required password, required name});
}

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);
  @override
  Future register({required email, required password, required name}) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
      );
      var data = await apiService.signUp(data: user.toJson());
      user = User.fromMap(data);
      return Right(user);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  FutureEither<User> login({required email, required password}) async {
    try {
      User user = User(
        id: "",
        name: "",
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
      );
      var data = await apiService.signIn(data: user.toJson());
      user = User.fromMap(data);
      return Right(user);
    } on Exception catch (e) {
      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}


// FutureEither<String>