import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

class SearchParams extends Equatable {
  const SearchParams(this.query);
  final String query;

  @override
  List<Object> get props => [query];
}

class SearchMovies implements Usecase<List<Movie>, SearchParams> {
  const SearchMovies(this._repository);
  final IMediaRepository _repository;

  @override
  Future<Either<Failure, List<Movie>>> call(SearchParams params) =>
      _repository.searchMovies(params.query);
}

class SearchTvShows implements Usecase<List<TvShow>, SearchParams> {
  const SearchTvShows(this._repository);
  final IMediaRepository _repository;

  @override
  Future<Either<Failure, List<TvShow>>> call(SearchParams params) =>
      _repository.searchTvShows(params.query);
}