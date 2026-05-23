import 'package:dartz/dartz.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

class GetPopularTvShows implements Usecase<List<TvShow>, NoParams> {
  const GetPopularTvShows(this._repository);
  final IMediaRepository _repository;

  @override
  Future<Either<Failure, List<TvShow>>> call(NoParams params) =>
      _repository.getPopularTvShows();
}