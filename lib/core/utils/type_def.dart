import 'package:dartz/dartz.dart';

import '../errors/failire.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;