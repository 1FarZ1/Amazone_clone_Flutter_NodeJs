import 'package:amazon_clone/core/utils/type_def.dart';

abstract class AuthRepo {
  FutureEither<String> login({required email, required password});
  FutureEither<String> register(
      {required email, required password, required name});
}

class AuthRepoImpl implements AuthRepo {
  
  @override
  FutureEither<String> register({required email, required password, required name}) {
    throw UnimplementedError();
  }
  
  @override
  FutureEither<String> login({required email, required password}) {
    throw UnimplementedError();
  }

  
}
