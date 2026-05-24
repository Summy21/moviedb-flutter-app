import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';

part 'search_state.freezed.dart';

/// Represents all possible states of the search screen.
///
/// [SearchLoaded] carries both movies and TV shows simultaneously
/// since TMDB multi-search returns mixed results.
@freezed
sealed class SearchState with _$SearchState {
  /// Initial state — search field is empty, no results shown.
  const factory SearchState.initial() = SearchInitial;

  /// Search request is in progress.
  const factory SearchState.loading() = SearchLoading;

  /// Search completed — both lists may be empty if no results found.
  const factory SearchState.loaded({
    required List<Movie> movies,
    required List<TvShow> tvShows,
  }) = SearchLoaded;

  /// Search failed — [message] describes what went wrong.
  const factory SearchState.error(String message) = SearchError;
}
