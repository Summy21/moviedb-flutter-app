import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';

/// Input parameters for [GetTvShowDetail].
class TvShowParams extends Equatable {
  const TvShowParams(this.id);

  /// TMDB TV show identifier.
  final int id;

  @override
  List<Object> get props => [id];
}

/// Returns the full detail of a single TV show identified by [TvShowParams.id].
///
/// Used by the detail screen to display extended information
/// not available in the list response — genres, tagline,
/// number of seasons, number of episodes, and status.
class GetTvShowDetail implements Usecase<MediaDetail, TvShowParams> {
  const GetTvShowDetail(this._repository);

  final IMediaRepository _repository;

  @override
  Future<Either<Failure, MediaDetail>> call(TvShowParams params) =>
      _repository.getTvShowDetail(params.id);
}
