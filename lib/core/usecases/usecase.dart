import 'package:dartz/dartz.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';

abstract class Usecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {}