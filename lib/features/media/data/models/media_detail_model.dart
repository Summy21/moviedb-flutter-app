import 'package:moviedb_flutter_app/features/media/domain/entities/media_detail.dart';

class MediaDetailModel {
  const MediaDetailModel({
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

  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final List<String> genres;
  final String status;
  final String tagline;
  final String releaseDate;
  final int? runtime;
  final int? numberOfSeasons;
  final int? numberOfEpisodes;

  // Para películas — usa "title" y "release_date"
  factory MediaDetailModel.fromMovieJson(Map<String, dynamic> json) {
    return MediaDetailModel(
      id: json['id'] as int,
      title: json['title'] as String,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int? ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e['name'] as String)
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      releaseDate: json['release_date'] as String? ?? '',
      runtime: json['runtime'] as int?,
      numberOfSeasons: null,
      numberOfEpisodes: null,
    );
  }

  // Para series — usa "name" y "first_air_date"
  factory MediaDetailModel.fromTvJson(Map<String, dynamic> json) {
    return MediaDetailModel(
      id: json['id'] as int,
      title: json['name'] as String,
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int? ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e['name'] as String)
              .toList() ??
          [],
      status: json['status'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      releaseDate: json['first_air_date'] as String? ?? '',
      runtime: null,
      numberOfSeasons: json['number_of_seasons'] as int?,
      numberOfEpisodes: json['number_of_episodes'] as int?,
    );
  }

  MediaDetail toEntity() {
    return MediaDetail(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      genres: genres,
      status: status,
      tagline: tagline,
      releaseDate: releaseDate,
      runtime: runtime,
      numberOfSeasons: numberOfSeasons,
      numberOfEpisodes: numberOfEpisodes,
    );
  }
}