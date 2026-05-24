/// Thrown by the data layer when the TMDB API returns an error response
/// or the HTTP request fails for any server-related reason.
///
/// This exception is caught by [MediaRepositoryImpl] and converted
/// to a [ServerFailure] before reaching the domain layer.
/// The domain layer never sees this exception directly.
class ServerException implements Exception {
  const ServerException(this.message);

  /// Human-readable description of the server error.
  /// Produced by [TmdbDataSource._handleDioError].
  final String message;

  @override
  String toString() => 'ServerException: $message';
}

/// Thrown when there is no internet connection
/// or the device cannot reach the TMDB servers.
///
/// Converted to [NetworkFailure] by the repository layer.
class NetworkException implements Exception {
  const NetworkException(this.message);

  /// Human-readable description of the network error.
  final String message;

  @override
  String toString() => 'NetworkException: $message';
}
