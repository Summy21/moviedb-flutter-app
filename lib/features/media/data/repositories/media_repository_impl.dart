import 'package:dartz/dartz.dart';
import 'package:moviedb_flutter_app/core/error/exceptions.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/features/media/data/datasources/i_media_datasource.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

class MediaRepositoryImpl implements IMediaRepository {
  const MediaRepositoryImpl(this._dataSource);

  final IMediaDataSource _dataSource;

  // ── Movies ────────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final models = await _dataSource.getPopularMovies();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    try {
      final models = await _dataSource.getTopRatedMovies();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MediaDetail>> getMovieDetail(int id) async {
    try {
      final model = await _dataSource.getMovieDetail(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies(String query) async {
    try {
      final models = await _dataSource.searchMovies(query);
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  // ── TV Shows ──────────────────────────────────────────────────────────────

  @override
  Future<Either<Failure, List<TvShow>>> getPopularTvShows() async {
    try {
      final models = await _dataSource.getPopularTvShows();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows() async {
    try {
      final models = await _dataSource.getTopRatedTvShows();
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MediaDetail>> getTvShowDetail(int id) async {
    try {
      final model = await _dataSource.getTvShowDetail(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TvShow>>> searchTvShows(String query) async {
    try {
      final models = await _dataSource.searchTvShows(query);
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}