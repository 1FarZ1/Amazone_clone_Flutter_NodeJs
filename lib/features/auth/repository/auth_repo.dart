import 'dart:developer';

import 'package:amazon_clone/core/api_service.dart';
import 'package:amazon_clone/core/errors/failire.dart';
import 'package:amazon_clone/core/utils/type_def.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../models/user.dart';

abstract class AuthRepo {
  FutureEither<User> login({required email, required password});
  FutureEither<User> register(
      {required email, required password, required name});
  FutureEither<User> getUserData({required token});
}

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;

  AuthRepoImpl(this.apiService);
  @override
  FutureEither<User> register(
      {required email, required password, required name}) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "", cart: [],
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
        token: "", cart: [],
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

  @override
  FutureEither<User> getUserData({required token}) async {
    try {
      var res = await apiService.isValid(token: token);
      if (res == true) {
        log(
          "token is valid",
        );
        var data = await apiService.getUserData(token: token);
        var user = User.fromMap(data);
        return Right(user);
      }
      log(
        "token not valid",
      );
      return Left(ServerFailure("User not found"));
    } on Exception catch (e) {

      if (e is DioError) {
        return Left(ServerFailure.fromDioError(e));
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}


// FutureEither<String>