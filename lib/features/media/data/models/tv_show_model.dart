import 'package:moviedb_flutter_app/features/media/domain/entities/tv_show.dart';

/// Data Transfer Object for a TV show from the TMDB API.
///
/// Structurally similar to [MovieModel] but maps different
/// TMDB field names — TV shows use "name" instead of "title"
/// and "first_air_date" instead of "release_date".
class TvShowModel {
  const TvShowModel({
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

  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final String firstAirDate;
  final List<int> genreIds;

  /// Deserializes a TMDB TV show JSON object into a [TvShowModel].
  factory TvShowModel.fromJson(Map<String, dynamic> json) {
    return TvShowModel(
      id: json['id'] as int,
      name: json['name'] as String,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int? ?? 0,
      firstAirDate: json['first_air_date'] as String? ?? '',
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );
  }

  /// Converts this model to the domain entity [TvShow].
  TvShow toEntity() {
    return TvShow(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      firstAirDate: firstAirDate,
      genreIds: genreIds,
    );
  }
}