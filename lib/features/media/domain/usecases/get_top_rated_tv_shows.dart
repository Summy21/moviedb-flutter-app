import 'package:dartz/dartz.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

/// Returns a list of TV shows sorted by vote average descending.
///
/// Delegates directly to [IMediaRepository.getTopRatedTvShows].
class GetTopRatedTvShows implements Usecase<List<TvShow>, NoParams> {
  const GetTopRatedTvShows(this._repository);

  final IMediaRepository _repository;

  @override
  Future<Either<Failure, List<TvShow>>> call(NoParams params) =>
      _repository.getTopRatedTvShows();
}
