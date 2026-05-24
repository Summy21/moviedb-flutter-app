import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moviedb_flutter_app/core/constants/api_constants.dart';

/// Configured Dio HTTP client for TMDB API communication.
///
/// Pre-configured with:
/// - Base URL pointing to TMDB API v3
/// - API key injected as a default query parameter on every request
/// - Language set to es-ES for localized responses
/// - Connection and receive timeouts to avoid hanging requests
/// - LogInterceptor for debugging in development
///
/// Used as a singleton in the injection container — one instance
/// shared across all datasources.
class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        queryParameters: {'api_key': ApiConstants.apiKey, 'language': 'es-ES'},
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onError: (error, handler) {
            debugPrint('[DioError] ${error.type}: ${error.message}');
            handler.next(error);
          },
        ),
      );
    }
  }

  late final Dio _dio;

  /// The configured Dio instance.
  /// Injected into [TmdbDataSource] via constructor.
  Dio get dio => _dio;
}
