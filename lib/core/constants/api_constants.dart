/// Central registry for all TMDB API constants.
///
/// All base URLs, endpoint paths, and URL helper methods
/// are defined here to avoid magic strings scattered across the codebase.
/// API key is loaded from environment variables — never hardcoded.
class ApiConstants {
  // Prevent instantiation — this is a pure constants class.
  ApiConstants._();

  /// TMDB API key loaded from environment variables at compile time.
  ///
  /// Injected via --dart-define=TMDB_API_KEY=your_key.
  /// Never hardcode this value in source code.
  static const String apiKey = String.fromEnvironment('TMDB_API_KEY');

  /// Base URL for all TMDB API v3 requests.
  static const String baseUrl = 'https://api.themoviedb.org/3';

  /// Base URL for poster images at 500px width.
  /// Append [posterPath] from any movie or TV show response.
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  /// Base URL for backdrop images at 1280px width.
  /// Used for full-screen backgrounds in the detail screen.
  static const String backdropBaseUrl = 'https://image.tmdb.org/t/p/w1280';

  // ── Endpoints ─────────────────────────────────────────────────────────────

  /// Returns movies sorted by popularity descending.
  static const String popularMovies = '/movie/popular';

  /// Returns movies sorted by vote average descending.
  static const String topRatedMovies = '/movie/top_rated';

  /// Returns TV shows sorted by popularity descending.
  static const String popularTvShows = '/tv/popular';

  /// Returns TV shows sorted by vote average descending.
  static const String topRatedTvShows = '/tv/top_rated';

  /// Base path for movie detail. Append /{id} to get a specific movie.
  static const String movieDetail = '/movie';

  /// Base path for TV show detail. Append /{id} to get a specific show.
  static const String tvShowDetail = '/tv';

  /// Multi-search endpoint. Accepts a query param and returns
  /// mixed results of movies, TV shows, and people.
  static const String searchMulti = '/search/multi';

  static const String searchMovies = '/search/movie';

  static const String searchTvShows = '/search/tv';

  // ── URL Helpers ───────────────────────────────────────────────────────────

  /// Builds a full poster image URL from a TMDB [path].
  ///
  /// Returns empty string if [path] is null — the UI should
  /// handle this case with a placeholder widget.
  static String imageUrl(String? path) =>
      path != null ? '$imageBaseUrl$path' : '';

  /// Builds a full backdrop image URL from a TMDB [path].
  ///
  /// Returns empty string if [path] is null.
  static String backdropUrl(String? path) =>
      path != null ? '$backdropBaseUrl$path' : '';
}
