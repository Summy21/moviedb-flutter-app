import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        queryParameters: {
          // Injected on every request — no need to add manually per call.
          'api_key': ApiConstants.apiKey,
          // Requests localized content when available.
          'language': 'es-ES',
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        // Use print for simplicity — replace with a logger in production.
        logPrint: (log) => debugPrint(log.toString()),
      ),
    );
  }

  late final Dio _dio;

  /// The configured Dio instance.
  /// Injected into [TmdbDataSource] via constructor.
  Dio get dio => _dio;
}
