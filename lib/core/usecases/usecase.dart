import 'package:dartz/dartz.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';

/// Base contract for all use cases in the application.
///
/// Each use case represents a single user action or business operation.
/// [T] is the success return type.
/// [Params] is the input required to execute the use case.
///
/// Returns [Either<Failure, Type>] forcing explicit handling
/// of both success and error cases at compile time.
abstract class Usecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// Used as parameter type for use cases that require no input.
class NoParams {}
