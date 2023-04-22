import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/product.dart';

const uri = 'http://192.168.1.34:8001';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      headers: {'Content-Type': 'application/json', "Charset": "UTF-8"},
    ),
  );
  Future signUp({required data}) async {
    Response result = await _dio.post('$uri/api/signup',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: data);
    return result.data;
  }

  Future signIn({required data}) async {
    Response result = await _dio.post('$uri/api/signIn',
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
        data: data);
    return result.data;
  }

  Future isValid({required token}) async {
    log("token : $token");
    var tokenRes = await _dio.post('$uri/api/tokenIsValid',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token ?? ""
          },
        ));
    return tokenRes.data;
  }

  Future getUserData({required token}) async {
    var tokenRes = await _dio.get('$uri/',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token ?? ""
          },
        ));

    return tokenRes.data;
  }

  Future addProduct({required token, required Product product}) async {
    var tokenRes = await _dio.post('$uri/admin/add-product',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token ?? ""
          },
        ),
        data: product.toJson());

    return tokenRes.data;
  }

  Future getPosts({required token}) async {
    var res = await _dio.get('$uri/admin/all-products',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        ));
    return res.data["products"];
  }

  Future deletePost({required token ,required id}) async {
    var res = await _dio.post('$uri/admin/delete-product',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
          
        ),data: {
          id:id
        });
    return res.data["products"];
  }
}
