import 'package:equatable/equatable.dart';

/// Represents a movie in the domain layer.
///
/// This is a pure Dart class with no external dependencies —
/// no serialization, no Flutter, no third-party libraries.
/// Data comes from [MovieModel.toEntity()] in the data layer.
class Movie extends Equatable {
  const Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
    required this.genreIds,
  });

  /// TMDB unique identifier.
  final int id;

  /// Localized movie title.
  final String title;

  /// Plot summary in the requested language.
  final String overview;

  /// Poster image path. Combine with [ApiConstants.imageUrl] to get full URL.
  /// Can be null if TMDB has no poster for this movie.
  final String? posterPath;

  /// Backdrop image path. Combine with [ApiConstants.backdropUrl].
  /// Can be null if TMDB has no backdrop for this movie.
  final String? backdropPath;

  /// Average user rating from 0.0 to 10.0.
  final double voteAverage;

  /// Total number of user votes.
  final int voteCount;

  /// Release date in ISO 8601 format (YYYY-MM-DD).
  final String releaseDate;

  /// List of TMDB genre IDs associated with this movie.
  final List<int> genreIds;

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterPath,
    backdropPath,
    voteAverage,
    voteCount,
    releaseDate,
    genreIds,
  ];
}
