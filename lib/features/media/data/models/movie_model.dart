import 'package:moviedb_flutter_app/features/media/domain/entities/movie.dart';

/// Data Transfer Object for a movie from the TMDB API.
///
/// Responsible for:
/// - Deserializing raw JSON from TMDB into a typed Dart object
/// - Converting to the domain entity [Movie] via [toEntity]
///
/// Intentionally separate from [Movie] — if TMDB changes a field name,
/// only this class changes. The domain entity remains stable.
class MovieModel {
  const MovieModel({
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

  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;
  final List<int> genreIds;

  /// Deserializes a TMDB movie JSON object into a [MovieModel].
  ///
  /// Handles nullable fields defensively — TMDB occasionally omits
  /// fields like [posterPath] or returns empty strings for [overview].
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int? ?? 0,
      releaseDate: json['release_date'] as String? ?? '',
      genreIds:
          (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );
  }

  /// Converts this model to the domain entity [Movie].
  ///
  /// Called by [MediaRepositoryImpl] after fetching from the datasource.
  /// The domain layer only ever sees [Movie], never [MovieModel].
  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      releaseDate: releaseDate,
      genreIds: genreIds,
    );
  }
}
