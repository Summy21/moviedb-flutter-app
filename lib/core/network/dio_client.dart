import 'package:dio/dio.dart';
import 'package:moviedb_flutter_app/core/constants/api_constants.dart';

class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        queryParameters: {
          'api_key': ApiConstants.apiKey,
          'language': 'es-ES',
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: false,
        responseBody: false,
        logPrint: (log) => print(log),
      ),
    );
  }

  late final Dio _dio;

  Dio get dio => _dio;
}