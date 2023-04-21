import 'dart:developer';

import 'package:amazon_clone/core/api_service.dart';
import 'package:amazon_clone/core/utils/type_def.dart';

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
      await apiService.signUp(data: user.toJson());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future login({required email, required password}) async {
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
      print(user.toJson());
    } catch (e) {
      log(e.toString());
    }
  }
}


// FutureEither<String>