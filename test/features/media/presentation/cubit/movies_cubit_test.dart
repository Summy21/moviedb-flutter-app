import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/core/usecases/usecase.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_popular_movies.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_top_rated_movies.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/movies_cubit.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/movies_state.dart';

// Mocks
class MockGetPopularMovies extends Mock implements GetPopularMovies {}

class MockGetTopRatedMovies extends Mock implements GetTopRatedMovies {}

void main() {
  late MoviesCubit cubit;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  // Sample movie for test assertions
  final tMovie = Movie(
    id: 550,
    title: 'Fight Club',
    overview: 'An insomniac office worker.',
    posterPath: '/poster.jpg',
    backdropPath: '/backdrop.jpg',
    voteAverage: 8.4,
    voteCount: 32014,
    releaseDate: '1999-10-15',
    genreIds: const [18, 53],
  );

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    cubit = MoviesCubit(
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
    registerFallbackValue(NoParams());
  });

  tearDown(() => cubit.close());

  test('initial state is MoviesInitial', () {
    expect(cubit.state, const MoviesInitial());
  });

  group('fetchPopularMovies', () {
    blocTest<MoviesCubit, MoviesState>(
      'emits [loading, loaded] when use case succeeds',
      build: () {
        when(
          () => mockGetPopularMovies(any()),
        ).thenAnswer((_) async => Right([tMovie]));
        return cubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => [
        const MoviesLoading(),
        MoviesLoaded([tMovie]),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'emits [loading, error] when use case fails',
      build: () {
        when(() => mockGetPopularMovies(any())).thenAnswer(
          (_) async => const Left(ServerFailure('Connection error')),
        );
        return cubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => [
        const MoviesLoading(),
        const MoviesError('Connection error'),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'emits [loading, loaded] with empty list when no movies found',
      build: () {
        when(
          () => mockGetPopularMovies(any()),
        ).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.fetchPopularMovies(),
      expect: () => [const MoviesLoading(), const MoviesLoaded([])],
    );
  });

  group('fetchTopRatedMovies', () {
    blocTest<MoviesCubit, MoviesState>(
      'emits [loading, loaded] when use case succeeds',
      build: () {
        when(
          () => mockGetTopRatedMovies(any()),
        ).thenAnswer((_) async => Right([tMovie]));
        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedMovies(),
      expect: () => [
        const MoviesLoading(),
        MoviesLoaded([tMovie]),
      ],
    );

    blocTest<MoviesCubit, MoviesState>(
      'emits [loading, error] when use case fails',
      build: () {
        when(
          () => mockGetTopRatedMovies(any()),
        ).thenAnswer((_) async => const Left(ServerFailure('Server error')));
        return cubit;
      },
      act: (cubit) => cubit.fetchTopRatedMovies(),
      expect: () => [const MoviesLoading(), const MoviesError('Server error')],
    );
  });
}
