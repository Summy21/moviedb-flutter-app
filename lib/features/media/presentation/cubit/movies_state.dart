import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';

part 'movies_state.freezed.dart';

/// Represents all possible states of the movies list screen.
///
/// Used by both popular and top rated movie lists.
/// [MoviesLoaded] carries the fetched list — empty list
/// is a valid loaded state when TMDB returns no results.
@freezed
sealed class MoviesState with _$MoviesState {
  /// Initial state before any fetch is triggered.
  const factory MoviesState.initial() = MoviesInitial;

  /// Fetch is in progress — show loading indicator.
  const factory MoviesState.loading() = MoviesLoading;

  /// Fetch completed successfully.
  const factory MoviesState.loaded(List<Movie> movies) = MoviesLoaded;

  /// Fetch failed — [message] describes what went wrong.
  const factory MoviesState.error(String message) = MoviesError;
}