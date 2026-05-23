import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

class TvShowParams extends Equatable {
  const TvShowParams(this.id);
  final int id;

  @override
  List<Object> get props => [id];
}

class GetTvShowDetail implements Usecase<MediaDetail, TvShowParams> {
  const GetTvShowDetail(this._repository);
  final IMediaRepository _repository;

  @override
  Future<Either<Failure, MediaDetail>> call(TvShowParams params) =>
      _repository.getTvShowDetail(params.id);
}