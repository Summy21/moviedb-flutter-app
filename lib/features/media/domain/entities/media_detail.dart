import 'package:equatable/equatable.dart';

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
    this.numberOfEpisodes
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
  final String releaseDate;  // both
  final int? runtime;        // just movies
  final int? numberOfSeasons; // just tv — pending confirmation
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
        numberOfEpisodes
      ];
}