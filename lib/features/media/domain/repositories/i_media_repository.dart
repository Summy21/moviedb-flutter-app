import 'package:dartz/dartz.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';

/// Contract for all media data operations.
///
/// Lives in the domain layer — defines WHAT can be done,
/// not HOW. The concrete implementation [MediaRepositoryImpl]
/// lives in the data layer and is injected via GetIt.
///
/// All methods return [Either<Failure, T>] to force explicit
/// error handling at the call site.
abstract class IMediaRepository {
  /// Returns movies sorted by popularity descending.
  Future<Either<Failure, List<Movie>>> getPopularMovies();

  /// Returns movies sorted by vote average descending.
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  /// Returns full detail for a movie identified by [id].
  Future<Either<Failure, MediaDetail>> getMovieDetail(int id);

  /// Searches movies matching [query] using TMDB multi-search.
  Future<Either<Failure, List<Movie>>> searchMovies(String query);

  /// Returns TV shows sorted by popularity descending.
  Future<Either<Failure, List<TvShow>>> getPopularTvShows();

  /// Returns TV shows sorted by vote average descending.
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();

  /// Returns full detail for a TV show identified by [id].
  Future<Either<Failure, MediaDetail>> getTvShowDetail(int id);

  /// Searches TV shows matching [query] using TMDB multi-search.
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
}
