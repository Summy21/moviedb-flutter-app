import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moviedb_flutter_app/core/network/dio_client.dart';
import 'package:moviedb_flutter_app/features/media/data/datasources/i_media_datasource.dart';
import 'package:moviedb_flutter_app/features/media/data/datasources/tmdb_datasource.dart';
import 'package:moviedb_flutter_app/features/media/data/repositories/media_repository_impl.dart';
import 'package:moviedb_flutter_app/features/media/domain/repositories/i_media_repository.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_movie_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_popular_movies.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_popular_tv_shows.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_top_rated_movies.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/get_tv_show_detail.dart';
import 'package:moviedb_flutter_app/features/media/domain/usecases/search_media.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/detail_cubit.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/movies_cubit.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/search_cubit.dart';
import 'package:moviedb_flutter_app/features/media/presentation/cubit/tv_shows_cubit.dart';

/// Global service locator instance.
///
/// Access registered dependencies anywhere in the app via [sl<Type>()].
/// All registrations are performed once at app startup in [initDependencies].
final sl = GetIt.instance;

/// Registers all application dependencies in the correct order.
///
/// Registration order matters — each layer depends on the one below it:
/// 1. External services (Dio)
/// 2. Data sources (depend on Dio)
/// 3. Repositories (depend on data sources)
/// 4. Use cases (depend on repositories)
/// 5. Cubits (depend on use cases) — registered as factory
///    so each screen gets a fresh instance
///
/// Called once in [main] before [runApp].
Future<void> initDependencies() async {
  // ── 1. External ───────────────────────────────────────────────────────────

  /// Single Dio instance shared across all datasources.
  /// Pre-configured with base URL, API key, and timeouts.
  sl.registerSingleton<Dio>(DioClient().dio);

  // ── 2. Data sources ───────────────────────────────────────────────────────

  /// Registered against the interface so the repository
  /// depends on the abstraction, not the concrete class.
  sl.registerFactory<IMediaDataSource>(() => TmdbDataSource(sl()));

  // ── 3. Repositories ───────────────────────────────────────────────────────

  /// Registered against [IMediaRepository] — domain never
  /// knows that [MediaRepositoryImpl] exists.
  sl.registerFactory<IMediaRepository>(() => MediaRepositoryImpl(sl()));

  // ── 4. Use cases ──────────────────────────────────────────────────────────

  // Movies
  sl.registerFactory(() => GetPopularMovies(sl()));
  sl.registerFactory(() => GetTopRatedMovies(sl()));
  sl.registerFactory(() => GetMovieDetail(sl()));

  // TV Shows
  sl.registerFactory(() => GetPopularTvShows(sl()));
  sl.registerFactory(() => GetTopRatedTvShows(sl()));
  sl.registerFactory(() => GetTvShowDetail(sl()));

  // Search
  sl.registerFactory(() => SearchMovies(sl()));
  sl.registerFactory(() => SearchTvShows(sl()));

  // ── 5. Cubits ─────────────────────────────────────────────────────────────

  /// Registered as factory — each screen gets a fresh Cubit instance.
  /// This prevents state from leaking between screen navigations.
  sl.registerFactory(
    () => MoviesCubit(getPopularMovies: sl(), getTopRatedMovies: sl()),
  );

  sl.registerFactory(
    () => TvShowsCubit(getPopularTvShows: sl(), getTopRatedTvShows: sl()),
  );

  sl.registerFactory(
    () => DetailCubit(getMovieDetail: sl(), getTvShowDetail: sl()),
  );

  sl.registerFactory(
    () => SearchCubit(searchMovies: sl(), searchTvShows: sl()),
  );
}
