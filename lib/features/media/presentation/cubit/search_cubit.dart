import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/search_media.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/search_state.dart';

/// Manages state for the search screen.
///
/// Runs movie and TV show searches in parallel using [Future.wait]
/// to minimize total wait time — both requests fire simultaneously
/// instead of sequentially.
class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required SearchMovies searchMovies,
    required SearchTvShows searchTvShows,
  }) : _searchMovies = searchMovies,
       _searchTvShows = searchTvShows,
       super(const SearchState.initial());

  final SearchMovies _searchMovies;
  final SearchTvShows _searchTvShows;

  /// Searches both movies and TV shows simultaneously for [query].
  ///
  /// Uses [Future.wait] to fire both requests in parallel.
  /// If either fails, emits [SearchState.error].
  /// If both succeed, emits [SearchState.loaded] with both lists.

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      emit(const SearchState.initial());
      return;
    }

    emit(const SearchState.loading());

    // Fire both requests simultaneously — independent operations
    // Explicit types because Future.wait loses type inference with Either
    final results = await Future.wait<dynamic>([
      _searchMovies(SearchParams(query)),
      _searchTvShows(SearchParams(query)),
    ]);

    // Cast explicitly after Future.wait
    final moviesResult = results[0] as Either<Failure, List<Movie>>;
    final tvShowsResult = results[1] as Either<Failure, List<TvShow>>;

    // Handle failures
    if (moviesResult.isLeft()) {
      moviesResult.fold(
        (failure) => emit(SearchState.error(failure.message)),
        (_) {},
      );
      return;
    }

    if (tvShowsResult.isLeft()) {
      tvShowsResult.fold(
        (failure) => emit(SearchState.error(failure.message)),
        (_) {},
      );
      return;
    }

    // Both succeeded
    moviesResult.fold(
      (_) {},
      (movies) => tvShowsResult.fold(
        (_) {},
        (tvShows) => emit(SearchState.loaded(movies: movies, tvShows: tvShows)),
      ),
    );
  }

  /// Resets search to initial state.
  /// Called when the search field is cleared.
  void clear() => emit(const SearchState.initial());
}
