import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

/// Input parameters for search use cases.
///
/// Shared between [SearchMovies] and [SearchTvShows]
/// since both require the same input — a text query.
class SearchParams extends Equatable {
  const SearchParams(this.query);

  /// Text to search for. Passed directly to TMDB multi-search endpoint.
  final String query;

  @override
  List<Object> get props => [query];
}

/// Searches for movies matching [SearchParams.query].
///
/// Uses TMDB multi-search endpoint and filters results
/// to only return items with media_type == "movie".
class SearchMovies implements Usecase<List<Movie>, SearchParams> {
  const SearchMovies(this._repository);

  final IMediaRepository _repository;

  @override
  Future<Either<Failure, List<Movie>>> call(SearchParams params) =>
      _repository.searchMovies(params.query);
}

/// Searches for TV shows matching [SearchParams.query].
///
/// Uses TMDB multi-search endpoint and filters results
/// to only return items with media_type == "tv".
class SearchTvShows implements Usecase<List<TvShow>, SearchParams> {
  const SearchTvShows(this._repository);

  final IMediaRepository _repository;

  @override
  Future<Either<Failure, List<TvShow>>> call(SearchParams params) =>
      _repository.searchTvShows(params.query);
}
