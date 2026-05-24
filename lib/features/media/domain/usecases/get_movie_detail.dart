import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

/// Input parameters for [GetMovieDetail].
///
/// Wraps the movie [id] in a typed class to maintain
/// consistency with the [Usecase] contract.
class MovieParams extends Equatable {
  const MovieParams(this.id);

  /// TMDB movie identifier.
  final int id;

  @override
  List<Object> get props => [id];
}

/// Returns the full detail of a single movie identified by [MovieParams.id].
///
/// Used by the detail screen to display extended information
/// not available in the list response — genres, tagline,
/// runtime, and status.
class GetMovieDetail implements Usecase<MediaDetail, MovieParams> {
  const GetMovieDetail(this._repository);

  final IMediaRepository _repository;

  @override
  Future<Either<Failure, MediaDetail>> call(MovieParams params) =>
      _repository.getMovieDetail(params.id);
}
