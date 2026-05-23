/// Base class for all domain-level failures.
///
/// Failures represent expected error conditions that the UI
/// should handle gracefully. They are produced by the repository
/// layer when a [ServerException] or [NetworkException] is caught.
abstract class Failure {
  const Failure(this.message);

  /// Human-readable description of what went wrong.
  final String message;
}

/// Failure produced when the TMDB API returns an error response
/// or the request cannot be completed due to a server-side issue.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Failure produced when there is no internet connection
/// or the request times out.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}