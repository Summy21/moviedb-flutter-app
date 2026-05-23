import 'package:dartz/dartz.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';

abstract class IMediaRepository {
  // Movies
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MediaDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);

  // TV Shows
  Future<Either<Failure, List<TvShow>>> getPopularTvShows();
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();
  Future<Either<Failure, MediaDetail>> getTvShowDetail(int id);
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);
}