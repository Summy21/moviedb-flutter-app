import 'package:dio/dio.dart';
import 'package:moviedb_flutter_app/core/constants/api_constants.dart';
import 'package:moviedb_flutter_app/core/error/exceptions.dart';
import 'package:moviedb_flutter_app/features/media/data/datasources/i_media_datasource.dart';
import 'package:moviedb_flutter_app/features/media/data/models/media_detail_model.dart';
import 'package:moviedb_flutter_app/features/media/data/models/movie_model.dart';
import 'package:moviedb_flutter_app/features/media/data/models/tv_show_model.dart';

/// Concrete implementation of [IMediaDataSource] that communicates
/// directly with the TMDB REST API using Dio.
///
/// Throws [ServerException] on any network or API error.
/// Never returns [Either] — that responsibility belongs to
/// [MediaRepositoryImpl].
class TmdbDataSource implements IMediaDataSource {
  const TmdbDataSource(this._dio);

  final Dio _dio;

  // ── Movies ────────────────────────────────────────────────────────────────

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    try {
      final response = await _dio.get(ApiConstants.popularMovies);
      final List<dynamic> results = response.data['results'];
      return results
          .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    try {
      final response = await _dio.get(ApiConstants.topRatedMovies);
      final List<dynamic> results = response.data['results'];
      return results
          .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MediaDetailModel> getMovieDetail(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.movieDetail}/$id');
      return MediaDetailModel.fromMovieJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    try {
      // Use dedicated movie search for better accuracy
      final response = await _dio.get(
        ApiConstants.searchMovies,
        queryParameters: {'query': query},
      );
      final List<dynamic> results = response.data['results'];
      return results
          .map((json) => MovieModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // ── TV Shows ──────────────────────────────────────────────────────────────

  @override
  Future<List<TvShowModel>> getPopularTvShows() async {
    try {
      final response = await _dio.get(ApiConstants.popularTvShows);
      final List<dynamic> results = response.data['results'];
      return results
          .map((json) => TvShowModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TvShowModel>> getTopRatedTvShows() async {
    try {
      final response = await _dio.get(ApiConstants.topRatedTvShows);
      final List<dynamic> results = response.data['results'];
      return results
          .map((json) => TvShowModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MediaDetailModel> getTvShowDetail(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.tvShowDetail}/$id');
      return MediaDetailModel.fromTvJson(
        response.data as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(_handleDioError(e));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TvShowModel>> searchTvShows(String query) async {
      try {
      // Use dedicated tv search for better accuracy
      final response = await _dio.get(ApiConstants.searchTvShows,
        queryParameters: {'query': query},
      );
      final List<dynamic> results = response.data['results'];
      return results
          .map((json) => TvShowModel.fromJson(json as Map<String, dynamic>))
          .toList();
      } on DioException catch (e) {
        throw ServerException(_handleDioError(e));
      } catch (e) {
        throw ServerException(e.toString());
    }
  }

  // ── Error handling ────────────────────────────────────────────────────────
  /// Converts a [DioException] into a human-readable error message.
  ///
  /// Handles timeout, bad response, and connection errors explicitly.
  /// Falls back to the raw Dio message for unexpected cases.
  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) return 'Invalid API key.';
        if (statusCode == 404) return 'Content not found.';
        return 'Server error ($statusCode).';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      default:
        return e.message ?? 'Unexpected error.';
    }
  }
}