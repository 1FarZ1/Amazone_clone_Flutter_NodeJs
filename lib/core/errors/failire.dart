import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');

      case DioErrorType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioErrorType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioErrorType.cancel:
        return ServerFailure('Request to ApiServer was canceld');

      case DioErrorType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure('Unexpected Error, Please try again!');
      default:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }
  factory ServerFailure.fromResponse(int? statuscode, dynamic res) {
    print(res);
    if (statuscode == 400 || statuscode == 401 || statuscode == 403) {
      return ServerFailure(res["error"]["message"]);
    } else if (statuscode == 404) {
      return ServerFailure("bad request! pls try again later ");
    } else if (statuscode == 500) {
      return ServerFailure("server going down ! pls try again later ");
    } else {
      return ServerFailure("something went wrong ! pls try again later ");
    }
  }
}

class CacheFailure extends Failure {
  CacheFailure(super.errorMessage);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.errorMessage);
}
