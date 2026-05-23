import 'package:dartz/dartz.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

/// Returns a list of movies sorted by vote average descending.
///
/// Delegates directly to [IMediaRepository.getTopRatedMovies].
class GetTopRatedMovies implements Usecase<List<Movie>, NoParams> {
  const GetTopRatedMovies(this._repository);

  final IMediaRepository _repository;

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) =>
      _repository.getTopRatedMovies();
}