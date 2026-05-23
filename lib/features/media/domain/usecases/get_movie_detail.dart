import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

class MovieParams extends Equatable {
  const MovieParams(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}

class GetMovieDetail implements Usecase<MediaDetail, MovieParams> {
  const GetMovieDetail(this._repository);
  final IMediaRepository _repository;

  @override
  Future<Either<Failure, MediaDetail>> call(MovieParams params) =>
      _repository.getMovieDetail(params.id);
}