import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:moviedb_flutter_app/core/error/failures.dart';
import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_movie_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_tv_show_detail.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/detail_cubit.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/detail_state.dart';

class MockGetMovieDetail extends Mock implements GetMovieDetail {}

class MockGetTvShowDetail extends Mock implements GetTvShowDetail {}

void main() {
  late DetailCubit cubit;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetTvShowDetail mockGetTvShowDetail;

  final tDetail = MediaDetail(
    id: 550,
    title: 'Fight Club',
    overview: 'An insomniac office worker.',
    posterPath: '/poster.jpg',
    backdropPath: '/backdrop.jpg',
    voteAverage: 8.4,
    voteCount: 32014,
    genres: const ['Drama', 'Thriller'],
    status: 'Released',
    tagline: 'Mischief. Mayhem. Soap.',
    releaseDate: '1999-10-15',
    runtime: 139,
  );

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetTvShowDetail = MockGetTvShowDetail();
    cubit = DetailCubit(
      getMovieDetail: mockGetMovieDetail,
      getTvShowDetail: mockGetTvShowDetail,
    );
    registerFallbackValue(const MovieParams(1));
    registerFallbackValue(const TvShowParams(1));
  });

  tearDown(() => cubit.close());

  test('initial state is DetailInitial', () {
    expect(cubit.state, const DetailInitial());
  });

  group('fetchMovieDetail', () {
    blocTest<DetailCubit, DetailState>(
      'emits [loading, loaded] when movie detail fetch succeeds',
      build: () {
        when(
          () => mockGetMovieDetail(any()),
        ).thenAnswer((_) async => Right(tDetail));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovieDetail(550),
      expect: () => [const DetailLoading(), DetailLoaded(tDetail)],
    );

    blocTest<DetailCubit, DetailState>(
      'emits [loading, error] when movie detail fetch fails',
      build: () {
        when(
          () => mockGetMovieDetail(any()),
        ).thenAnswer((_) async => const Left(ServerFailure('Not found')));
        return cubit;
      },
      act: (cubit) => cubit.fetchMovieDetail(550),
      expect: () => [const DetailLoading(), const DetailError('Not found')],
    );
  });

  group('fetchTvShowDetail', () {
    blocTest<DetailCubit, DetailState>(
      'emits [loading, loaded] when TV show detail fetch succeeds',
      build: () {
        when(
          () => mockGetTvShowDetail(any()),
        ).thenAnswer((_) async => Right(tDetail));
        return cubit;
      },
      act: (cubit) => cubit.fetchTvShowDetail(1396),
      expect: () => [const DetailLoading(), DetailLoaded(tDetail)],
    );
  });
}
