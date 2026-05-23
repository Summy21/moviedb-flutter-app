class ApiConstants {
  ApiConstants._();

  // API key loaded from environment variables
  // Never hardcode sensitive values in source code
  static const String apiKey = String.fromEnvironment('TMDB_API_KEY');

  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String backdropBaseUrl = 'https://image.tmdb.org/t/p/w1280';

  // Endpoints
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String popularTvShows = '/tv/popular';
  static const String topRatedTvShows = '/tv/top_rated';
  static const String movieDetail = '/movie';
  static const String tvShowDetail = '/tv';
  static const String searchMulti = '/search/multi';

  // Helpers
  static String imageUrl(String path) => '$imageBaseUrl$path';
  static String backdropUrl(String path) => '$backdropBaseUrl$path';
}