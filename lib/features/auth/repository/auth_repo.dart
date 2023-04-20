import 'package:amazon_clone/core/utils/type_def.dart';

abstract class AuthRepo{
  FutureEither<String> login();
  FutureEither<String> register();
}


class AuthRepoImpl implements AuthRepo{
  @override
  FutureEither<String> login() {
    throw UnimplementedError();
  }

  @override
  FutureEither<String> register() {
    throw UnimplementedError();
  }

}
