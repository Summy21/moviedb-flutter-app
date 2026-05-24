import 'package:equatable/equatable.dart';

/// Full detail representation of a movie or TV show.
///
/// Used exclusively in the detail screen. Contains richer data
/// than [Movie] or [TvShow] — genre names instead of IDs,
/// tagline, status, and media-specific fields.
///
/// Fields that only apply to one media type are nullable:
/// - [runtime] is only present for movies
/// - [numberOfSeasons] and [numberOfEpisodes] are only present for TV shows
class MediaDetail extends Equatable {
  const MediaDetail({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.status,
    required this.tagline,
    required this.releaseDate,
    this.runtime,
    this.numberOfSeasons,
    this.numberOfEpisodes,
  });

  /// TMDB unique identifier.
  final int id;

  /// Localized title or name.
  /// For movies this maps to "title", for TV shows to "name".
  final String title;

  /// Full plot summary in the requested language.
  final String overview;

  /// Poster image path. Combine with [ApiConstants.imageUrl].
  final String? posterPath;

  /// Backdrop image path. Combine with [ApiConstants.backdropUrl].
  final String? backdropPath;

  /// Average user rating from 0.0 to 10.0.
  final double voteAverage;

  /// Total number of user votes.
  final int voteCount;

  /// Resolved genre names (e.g. ["Drama", "Crime"]).
  /// Derived from the genres array in the TMDB response.
  final List<String> genres;

  /// Release or production status (e.g. "Released", "Ended").
  final String status;

  /// Short promotional phrase associated with the title.
  final String tagline;

  /// Release date for movies or first air date for TV shows.
  /// ISO 8601 format (YYYY-MM-DD).
  final String releaseDate;

  /// Movie duration in minutes. Null for TV shows.
  final int? runtime;

  /// Number of seasons. Null for movies.
  final int? numberOfSeasons;

  /// Total number of episodes. Null for movies.
  final int? numberOfEpisodes;

  @override
  List<Object?> get props => [
    id,
    title,
    overview,
    posterPath,
    backdropPath,
    voteAverage,
    voteCount,
    genres,
    status,
    tagline,
    releaseDate,
    runtime,
    numberOfSeasons,
    numberOfEpisodes,
  ];
}
