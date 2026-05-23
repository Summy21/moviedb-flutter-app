import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_popular_movies.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_top_rated_movies.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/movies_state.dart';

/// Manages state for the movies tab.
///
/// Receives [GetPopularMovies] and [GetTopRatedMovies] use cases
/// by injection — never imports repositories or datasources directly.
/// Follows the pattern: emit loading → call use case → fold → emit result.
class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit({
    required GetPopularMovies getPopularMovies,
    required GetTopRatedMovies getTopRatedMovies,
  })  : _getPopularMovies = getPopularMovies,
        _getTopRatedMovies = getTopRatedMovies,
        super(const MoviesState.initial());

  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;

  /// Fetches movies sorted by popularity.
  /// Called when the user selects the "Popular" filter.
  Future<void> fetchPopularMovies() async {
    emit(const MoviesState.loading());
    final result = await _getPopularMovies(NoParams());
    result.fold(
      (failure) => emit(MoviesState.error(failure.message)),
      (movies) => emit(MoviesState.loaded(movies)),
    );
  }

  /// Fetches movies sorted by vote average.
  /// Called when the user selects the "Top Rated" filter.
  Future<void> fetchTopRatedMovies() async {
    emit(const MoviesState.loading());
    final result = await _getTopRatedMovies(NoParams());
    result.fold(
      (failure) => emit(MoviesState.error(failure.message)),
      (movies) => emit(MoviesState.loaded(movies)),
    );
  }
}