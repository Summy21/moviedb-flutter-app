import 'package:equatable/equatable.dart';

/// Represents a TV show in the domain layer.
///
/// Pure Dart class with no external dependencies.
/// Structurally similar to [Movie] but with different field names
/// that reflect TMDB API conventions — TV shows use [name]
/// instead of title, and [firstAirDate] instead of releaseDate.
class TvShow extends Equatable {
  const TvShow({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
    required this.genreIds,
  });

  /// TMDB unique identifier.
  final int id;

  /// Localized TV show name.
  /// Note: TMDB uses "name" for TV shows, unlike "title" for movies.
  final String name;

  /// Plot summary in the requested language.
  final String overview;

  /// Poster image path. Combine with [ApiConstants.imageUrl].
  /// Can be null if TMDB has no poster for this show.
  final String? posterPath;

  /// Backdrop image path. Combine with [ApiConstants.backdropUrl].
  /// Can be null if TMDB has no backdrop for this show.
  final String? backdropPath;

  /// Average user rating from 0.0 to 10.0.
  final double voteAverage;

  /// Total number of user votes.
  final int voteCount;

  /// Date the first episode aired, in ISO 8601 format (YYYY-MM-DD).
  final String firstAirDate;

  /// List of TMDB genre IDs associated with this TV show.
  final List<int> genreIds;

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        voteCount,
        firstAirDate,
        genreIds,
      ];
}