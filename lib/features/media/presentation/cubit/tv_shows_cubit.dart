import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_popular_tv_shows.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/tv_shows_state.dart';

/// Manages state for the TV shows tab.
///
/// Mirrors [MoviesCubit] structure for consistency —
/// same pattern, different use cases and entity types.
class TvShowsCubit extends Cubit<TvShowsState> {
  TvShowsCubit({
    required GetPopularTvShows getPopularTvShows,
    required GetTopRatedTvShows getTopRatedTvShows,
  }) : _getPopularTvShows = getPopularTvShows,
       _getTopRatedTvShows = getTopRatedTvShows,
       super(const TvShowsState.initial());

  final GetPopularTvShows _getPopularTvShows;
  final GetTopRatedTvShows _getTopRatedTvShows;

  /// Fetches TV shows sorted by popularity.
  Future<void> fetchPopularTvShows() async {
    emit(const TvShowsState.loading());
    final result = await _getPopularTvShows(NoParams());
    result.fold(
      (failure) => emit(TvShowsState.error(failure.message)),
      (tvShows) => emit(TvShowsState.loaded(tvShows)),
    );
  }

  /// Fetches TV shows sorted by vote average.
  Future<void> fetchTopRatedTvShows() async {
    emit(const TvShowsState.loading());
    final result = await _getTopRatedTvShows(NoParams());
    result.fold(
      (failure) => emit(TvShowsState.error(failure.message)),
      (tvShows) => emit(TvShowsState.loaded(tvShows)),
    );
  }
}
