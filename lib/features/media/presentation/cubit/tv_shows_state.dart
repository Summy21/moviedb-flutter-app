import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';

part 'tv_shows_state.freezed.dart';

/// Represents all possible states of the TV shows list screen.
@freezed
sealed class TvShowsState with _$TvShowsState {
  /// Initial state before any fetch is triggered.
  const factory TvShowsState.initial() = TvShowsInitial;

  /// Fetch is in progress — show loading indicator.
  const factory TvShowsState.loading() = TvShowsLoading;

  /// Fetch completed successfully.
  const factory TvShowsState.loaded(List<TvShow> tvShows) = TvShowsLoaded;

  /// Fetch failed — [message] describes what went wrong.
  const factory TvShowsState.error(String message) = TvShowsError;
}
